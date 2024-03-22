using MediatR;
using Newtonsoft.Json.Linq;
using System.Reflection;
using DishNutriDataAPI.Models;
using DishNutriDataAPI.Requests;

namespace DishNutriDataAPI.Commands
{
    public class GetNutritionalDataCommand : IRequestHandler<GetNutritionalDataRequest, NutritionalData>
    {
        public async Task<NutritionalData> Handle(GetNutritionalDataRequest request, CancellationToken cancellationToken)
        {
            var result = new NutritionalData();
            result.SetAllPropertiesToValue(0);
            
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    var ingredientsString = string.Join('+',request.IngredientsWithWeight.Select(x => x["ingredient"]));

                    client.BaseAddress = new Uri("https://api.api-ninjas.com/v1/");
                    client.DefaultRequestHeaders.Add("X-Api-Key", Environment.GetEnvironmentVariable("ninja-api-key"));

                    HttpResponseMessage response = await client.GetAsync("nutrition?query="+ingredientsString);

                    if (response.IsSuccessStatusCode)
                    {
                        var responseString = await response.Content.ReadAsStringAsync();
                        var responseJson = JArray.Parse(responseString);

                        foreach (var ingredientNutriData in responseJson)
                        {
                            string? ingredientName = (string?)ingredientNutriData["name"];
                            if (ingredientName is null)
                            {
                                continue;
                            }
                            foreach (PropertyInfo prop in result.GetType().GetProperties())
                            {
                                decimal previousValue = (decimal)(prop.GetValue(result));
                                decimal ValueOfIngPer100g = (decimal)ingredientNutriData[prop.Name];

                                if (request.IngredientsWithWeight.Find(x => x.ContainsValue(ingredientName)).Count() == 0)
                                {
                                    prop.SetValue(result, null);
                                }
                                else
                                {
                                    decimal newValue;
                                    if (ValueOfIngPer100g == 0)
                                    {
                                        newValue = 0;
                                    }
                                    else
                                    { 
                                        double ingredientMass = (double)request.IngredientsWithWeight.Find(x => x.Values.Contains(ingredientName))["mass"];
                                        
                                        newValue = (decimal)ingredientMass / 100 * (decimal)ValueOfIngPer100g;
                                    }
                                    prop.SetValue(result, previousValue + newValue);
                                }
                            }
                        }
                    }
                }
                catch (HttpRequestException e)
                {
                    Console.WriteLine("Error: " + e.Message);
                }
            }

            return result;
        }
    }
}

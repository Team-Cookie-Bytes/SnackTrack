using DishNutriDataAPI.Requests;
using MediatR;
using Newtonsoft.Json.Linq;
using System.Text;

namespace DishNutriDataAPI.Commands
{
    public class GetIngredientsSuggestionCommand : IRequestHandler<GetIngredientsSuggestionRequest, List<string>>
    {
        public async Task<List<string>> Handle(GetIngredientsSuggestionRequest request, CancellationToken cancellationToken)
        {
            var result = new List<string>();
            

            // Create a new HttpRequestMessage with the multipart content
            var requestMessage = new HttpRequestMessage(HttpMethod.Post, Environment.GetEnvironmentVariable("ingredients-suggestion-api-url") + "/ingredients-suggestions");
            requestMessage.Content = new StringContent($"{{\"base64image\":\"{request.Base64File}\"}}", Encoding.UTF8, "application/json");

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    var response = await client.SendAsync(requestMessage);
                    if (response.IsSuccessStatusCode)
                    {
                        var responseString = await response.Content.ReadAsStringAsync();
                        var responseJson = JArray.Parse(responseString).Select(x => x.ToString());
                        return new List<string>(responseJson);
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

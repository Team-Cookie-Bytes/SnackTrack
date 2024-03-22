using MediatR;

namespace DishNutriDataAPI.Requests
{
    public class GetMassPredictionRequest : IRequest<List<Dictionary<string, object>>>
    {
        public string Base64File { get; set; }
        public List<string> Ingredients { get; set; }
        public GetMassPredictionRequest(string base64File, List<String> ingredients) 
        {
            Base64File = base64File;
            Ingredients = ingredients;
        }
    }
}

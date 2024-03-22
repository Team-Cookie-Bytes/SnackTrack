using MediatR;

namespace DishNutriDataAPI.Requests
{
    public class GetIngredientsSuggestionRequest : IRequest<List<string>>
    {
        public string Base64File { get; set; }
        public GetIngredientsSuggestionRequest(string base64File) 
        {
            Base64File = base64File;
        }
    }
}

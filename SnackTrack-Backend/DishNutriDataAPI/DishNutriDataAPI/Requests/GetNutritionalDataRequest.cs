using MediatR;
using DishNutriDataAPI.Models;

namespace DishNutriDataAPI.Requests
{
    public class GetNutritionalDataRequest : IRequest<NutritionalData>
    {
        public List<Dictionary<string, object>> IngredientsWithWeight { get; }
        public GetNutritionalDataRequest(List<Dictionary<string, object>> ingredientsWithWeight)
        {
            IngredientsWithWeight = ingredientsWithWeight;
        }
    }
}

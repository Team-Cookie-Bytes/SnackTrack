using DishNutriDataAPI.Models;
using DishNutriDataAPI.Requests;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace DishNutriDataAPI.Controllers
{
    [ApiController]
    [Route("ingredients-suggestion")]
    public class IngredientsSuggestionController : ControllerBase
    {
        IMediator mediator;

        public IngredientsSuggestionController(IMediator mediator)
        {
            this.mediator = mediator;
        }

        [HttpPost(Name = "IngredientsSuggestion")]
        [Produces(typeof(List<string>))]
        public async Task<List<string>> IngredientsSuggestion([FromBody] FileParameter fileParameter)
        {
            return await mediator.Send(new GetIngredientsSuggestionRequest(fileParameter.Base64File));
        }
    }
}

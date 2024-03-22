using DishNutriDataAPI.Models;
using DishNutriDataAPI.Requests;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace DishNutriDataAPI.Controllers
{
    [ApiController]
    [Route("mass-prediction")]
    public class MassPredictionController : ControllerBase
    {
        IMediator mediator;
        
        public MassPredictionController(IMediator mediator)
        {
            this.mediator = mediator;
        }

        [HttpPost(Name = "MassPrediction")]
        [Produces(typeof(List<Dictionary<string, object>>))]
        public async Task<List<Dictionary<string, object>>> MassPrediction([FromBody] FileWithIngredientsParameter parameters) 
        {            
            return await mediator.Send(new GetMassPredictionRequest(parameters.Base64File, parameters.Ingredients));
        }

    }
}

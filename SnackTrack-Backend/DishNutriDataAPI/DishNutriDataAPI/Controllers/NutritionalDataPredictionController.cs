using DishNutriDataAPI.Requests;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using DishNutriDataAPI.Models;

namespace DishNutriDataAPI.Controllers
{
    [ApiController]
    [Route("nutritional-data")]
    public class NutritionalDataPredictionController
    {
        IMediator mediator;
        
        public NutritionalDataPredictionController(IMediator mediator)
        {
            this.mediator = mediator;
        }

        [HttpPost(Name = "NutritionalData")]
        [Produces(typeof(List<string>))]
        public async Task<NutritionalData> NutritionalDataPrediction([FromBody] FileWithIngredientsParameter fileParameter)
        {
            var massPredictions = await mediator.Send(new GetMassPredictionRequest(fileParameter.Base64File, fileParameter.Ingredients));

            return await mediator.Send(new GetNutritionalDataRequest(massPredictions));
        }
    }
}

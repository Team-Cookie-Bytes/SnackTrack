namespace DishNutriDataAPI.Models
{
    public struct FileWithIngredientsParameter
    {
        public string Base64File { get; set; }
        public List<string > Ingredients { get; set;}
    }
}

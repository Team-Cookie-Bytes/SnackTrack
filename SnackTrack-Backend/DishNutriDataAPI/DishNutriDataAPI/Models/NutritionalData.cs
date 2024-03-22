using System.Reflection;

namespace DishNutriDataAPI.Models
{
    public class NutritionalData
    {
        public decimal? calories { get; set; }
        public decimal? carbohydrates_total_g { get; set; }
        public decimal? sugar_g { get; set; }
        public decimal? fat_total_g { get; set; }
        public decimal? fat_saturated_g { get; set; }
        public decimal? protein_g { get; set; }
        public decimal? sodium_mg { get; set; }
        public decimal? fiber_g { get; set; }

        public void SetAllPropertiesToValue(decimal value)
        {
            foreach (PropertyInfo prop in this.GetType().GetProperties())
            {
                prop.SetValue(this, value, null);
            }
        }
    }
}

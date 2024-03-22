namespace DishNutriDataAPI.Properties
{
    using System;
    using System.IO;

    public static class DotEnv
    {
        public static void Load()
        {
            // if (!File.Exists("../src/.env")) 
            // {
            //     Console.WriteLine("No .env file found.");
            //     return;
            // }

            var lines = new List<string>(){"ninja-api-key=EhSt/g5ZPWfUuxliMdRhpA==40xttVIR7w4urloS", "mass-prediction-api-url=http://mass-prediction-api:80", "ingredients-suggestion-api-url=http://ingredients-suggestions-api:80"};
                
            foreach (var line in lines)
            {
                string[] parts = line.Split(new[] { '=' }, 2, StringSplitOptions.None);

                if (parts.Length != 2)
                    continue;

                Console.WriteLine(parts[0] + " = " + parts[1]);

                Environment.SetEnvironmentVariable(parts[0], parts[1]);
            }
        }
    }
}
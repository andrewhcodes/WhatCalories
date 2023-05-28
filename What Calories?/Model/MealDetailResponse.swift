

import Foundation

struct MealDetailResponse: Codable {
    let mealDetails: [MealDetails]
    
    enum CodingKeys: String, CodingKey {
        case mealDetails = "meals"
    }
}

struct MealDetails: Codable {
    let id: String
    let name: String
    let instructions: String
    let imageURL: URL
    var ingredients: [String?]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case imageURL = "strMealThumb"
    }
    struct IngredientKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.stringValue = "\(intValue)";
            self.intValue = intValue
        }
    }
    
init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       id = try container.decode(String.self, forKey: .id)
       name = try container.decode(String.self, forKey: .name)
       instructions = try container.decode(String.self, forKey: .instructions)

    let thumbnailStr = try container.decode(String.self, forKey: .imageURL)
       if let imageURL = URL(string: thumbnailStr) {
           self.imageURL = imageURL
       }
       else {
           throw DataError.invalidURL
       }

       let ingredientsContainer = try decoder.container(keyedBy: IngredientKeys.self)

       var ingredients = [String]()
       for key in ingredientsContainer.allKeys {
           let string = try ingredientsContainer.decode(String?.self, forKey: key)

           if key.stringValue.hasPrefix("strIngredient"), let ingredient = string {
               if !ingredient.isEmpty {
                   ingredients.append(ingredient)
               }
           }
       }
       self.ingredients = ingredients
   }

}

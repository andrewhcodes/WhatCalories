//
//  MealResponse.swift
//  What Calories?
//
//  Created by Andrew Hernandez on 5/28/23.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}


/// Holds meal details
/// Conformed the struct to `Identifiable` to let Swift know that each item is UNIQUELY identifiable
/// `Identifiable` *needs* a variable/constant named `id`
struct Meal: Codable, Identifiable {
    let id: String // Identifiable conformance
    let name: String
    let thumbnail: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case thumbnail = "strMealThumb"
        case name = "strMeal"
    }
}

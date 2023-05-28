//
//  MealService.swift
//  What Calories?
//
//  Created by Andrew Hernandez on 5/28/23.
//

import Foundation

protocol MealServiceable {
    func getMeals(type: String) async -> Result<MealResponse, RequestError>
    func getMealDetails(id: Int) async -> Result<MealDetailResponse, RequestError>
}

class MealService: HTTPClient, MealServiceable {
    
    func getMeals(type: String) async -> Result<MealResponse, RequestError> {
        return await sendRequest(endpoint: MealEndpoint.getMeals(type: type), responseModel: MealResponse.self )
    }
    
    func getMealDetails(id: Int) async -> Result<MealDetailResponse, RequestError> {
        return await sendRequest(endpoint: MealEndpoint.getMealDetails(id: id), responseModel: MealDetailResponse.self)
    }
    
}

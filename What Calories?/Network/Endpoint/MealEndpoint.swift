

import Foundation

enum MealEndpoint: Endpoint {
    case getMeals(type: String)
    case getMealDetails(id: Int)
    
    var apiKey: String {
        return "1"
    }
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    var baseUrl: String {
        return "www.themealdb.com"
    }
    var path: String {
        switch self {
        case .getMeals:
            return "/api/json/v1/\(apiKey)/filter.php"
        case .getMealDetails:
            return "/api/json/v1/\(apiKey)/lookup.php"
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case .getMeals(let type):
            return [URLQueryItem(name: "c", value: type)]
        case .getMealDetails(let id):
            return [URLQueryItem(name: "i", value: "\(id)")]
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getMeals, .getMealDetails:
            return .get
        }
    }
}

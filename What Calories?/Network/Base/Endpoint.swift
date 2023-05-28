


import Foundation

protocol Endpoint {
    var apiKey: String { get }
    
    var scheme: String { get }
    
    var baseUrl: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: HTTPMethod { get }
}

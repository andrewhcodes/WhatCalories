

import Foundation

/// Why inherit from ObservableObject?
/// * Provides reactivity. i.e.
/// * It allows us to listen to changes in a variable and immediately act on it/change the view based on the change
@MainActor
class MealListViewModel: ObservableObject {
    
    @Published var meals: [Meal]?
    @Published var type = "Dessert" // Can be changed later to get meals of a specific category
    
    let mealService: MealServiceable
    
    init(service: MealServiceable = MealService()) {
        self.mealService = service
    }
    
    /// Retrieves the list of meals
    /// - Parameter onError: callback to trigger when the network call fails.
    func getMealList(onError: (RequestError) -> Void) async {
        let result = await mealService.getMeals(type: type)
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                self.meals = data.meals
            }
        case .failure(let error):
            onError(error)
        }
        
    }
}

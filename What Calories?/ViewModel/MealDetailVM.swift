

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    
    let id: Int
    
    @Published var meal: MealDetails?
    
    let mealService: MealServiceable

    init(id: Int, service: MealServiceable = MealService()) {
        self.id = id
        self.mealService = service
    }
    
    func getMeal(onError: (RequestError) -> Void) async {
        let result = await mealService.getMealDetails(id: self.id)
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                self.meal = data.mealDetails.first
            }
        case .failure(let error):
            onError(error)
        }
    }
}

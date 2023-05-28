

import SwiftUI

struct MealListCell<Content: View>: View {
    
    let meal: Meal
    let destination: Content
    
    /// Initializer
    /// * `@ViewBuilder` allows us to provide child views within a closure and do with it what we wish
    /// - Parameters:
    ///   - meal: Meal to render the cell data from
    ///   - destination: a SwiftUI view as a destination
    init(meal: Meal, @ViewBuilder destination: () -> Content) {
        self.meal = meal
        self.destination = destination()
    }
    
    var body: some View {
        HStack(alignment: .top) {
            RoundedAsyncImage(url: meal.thumbnail)
                .frame(width: ListMetrics.mealListCellHeight)
            Text(meal.name)
                .padding(.vertical, Padding.padding6)
                .bold()
        }
        .frame(height: ListMetrics.mealListCellHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backgroundGray)
        .background(NavigationLink("", destination: destination))
        .cornerRadius(ViewMetrics.cornerRadius10)
        .listRowSeparator(.hidden, edges: .all)
        .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
    }
}

struct MealListCell_Previews: PreviewProvider {
    static var previews: some View {
        MealListCell(meal: Meal(id: "52772",
                                name: "Teriyaki Chicken Casserole",
                                thumbnail: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!),
                     destination: {
            Text("AAA")
        })
    }
}


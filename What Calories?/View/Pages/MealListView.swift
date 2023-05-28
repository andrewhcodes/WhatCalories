//
//  MealListView.swift
//  What Calories?
//
//  Created by Andrew Hernandez on 5/28/23.
//

import SwiftUI

struct MealListView: View {
    
    @StateObject var viewModel = MealListViewModel()
    
    @State private var errorMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // If meals exist, show a list of meals. If not, show a loader
                if let meals = viewModel.meals {
                    List(meals) { meal in
                        MealListCell(meal: meal) {
                            MealDetailView(id: Int(meal.id) ?? -99)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Desserts")
        }
        .onAppear {
            Task {
                await viewModel.getMealList { error in
                    errorMessage = error.customMessage
                    showAlert.toggle()
                }
            }
        }
        .alert(errorMessage, isPresented: $showAlert) {
            Button("Ok") {
                showAlert.toggle()
            }
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}

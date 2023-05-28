//
//  MealDetailView.swift
//  What Calories?
//
//  Created by Andrew Hernandez on 5/28/23.
//

import SwiftUI

struct MealDetailView: View {
    
    @StateObject private var viewModel: MealDetailViewModel
    
    @State private var errorMessage = ""
    @State private var showAlert = false
    
    init(id: Int) {
        self._viewModel = StateObject(wrappedValue: MealDetailViewModel(id: id))
    }
    
    // Row layout for the Grid
    private let rows = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
    ]
    
    var body: some View {
        ZStack {
            // If a meal exists, show the meal. If not, show a loader
            if let detail = viewModel.meal {
                ScrollView {
                    LazyVStack(spacing: ViewMetrics.vStackSpacing20) {
                        // Group to add a collective style to all the embedded views
                        Group {
                            RoundedAsyncImage(url: detail.imageURL)
                                .frame(height: 200)
                            Text(detail.name)
                                .font(.title)
                                .bold()
                            Text("Ingredients")
                                .font(.title3)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows) {
                                ForEach(detail.ingredients, id: \.self) { ingredient in
                                    CapsuleText(text: ingredient)
                                }
                            }
                            .padding(.horizontal)
                        }
                        Group {
                            Text("Description")
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(detail.instructions)
                        }
                        .padding(.horizontal)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.getMeal { error in
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

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(id: 52772)
    }
}

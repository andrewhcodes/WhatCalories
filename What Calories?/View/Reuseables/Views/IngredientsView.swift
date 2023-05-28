//
//  IngredientsView.swift
//  What Calories?
//
//  Created by Andrew Hernandez on 5/28/23.
//

import SwiftUI

struct CapsuleText: View {
    
    var text: String?
    
    var body: some View {
        Text(text ?? "")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: ViewMetrics.cornerRadius10)
                .fill(Color.gray.opacity(0.2))
            )
    }
}

struct CapsuleText_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleText(text: "Hello")
    }
}

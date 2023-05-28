

import SwiftUI

struct RoundedAsyncImage: View {
    
    let url: URL?
    var cornerRadius: CGFloat = ViewMetrics.cornerRadius10
    
    var body: some View {
        Color.clear
            .overlay {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct ClippedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedAsyncImage(url: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"))
    }
}


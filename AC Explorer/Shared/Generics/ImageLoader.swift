//
//  SwiftUIView.swift
//  AC
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct ImageLoader: View {
    @State var url: String
    @State var size: CGFloat
    
    var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(
                url: URL(string: url),
                transaction: Transaction(animation: .spring())
            ) { phase in
                switch phase {
                case .empty:
                    Loader()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .transition(.scale(scale: 0.88, anchor: .center))
                case .failure:
                    Loader()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: size, height: size)
            
        } else {
            if let url = URL(string: url), let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:96, height: 96)
            }
        }
    }
}

struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoader(url: VillagerDummy[0].image_url, size: 64)
    }
}


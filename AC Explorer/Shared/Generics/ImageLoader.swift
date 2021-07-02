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
        if #available(iOS 15.0, macOS 12.0, *) {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
            } placeholder: {
                VStack {
                    Loader()
                }.frame(width: size, height: size)
            }
        } else {
#if os(iOS)
            if let url = URL(string: url), let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:96, height: 96)
            }
#endif
        }
    }
}

struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoader(url: VillagerDummy[0].image_url, size: 64)
    }
}


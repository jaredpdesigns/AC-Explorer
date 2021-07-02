//
//  Small.swift
//  AC BirthdaysExtension
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct Small : View {
    @State var villager: Villager = VillagerDummy[0]
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Image(systemName: "sparkles")
                        .imageScale(.small)
                        .opacity(0.5)
                    Spacer()
                    Image(systemName: "sparkles")
                        .imageScale(.small)
                        .opacity(0.5)
                }
                if let url = URL(string: villager.image_url), let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:96, height: 96)
                }
            }
            Text(villager.name)
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor(hexString: villager.text_color)!))
        .foregroundColor(Color(UIColor(hexString: villager.title_color)!))
    }
}

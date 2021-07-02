//
//  Small.swift
//  AC BirthdaysExtension
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct Medium : View {
    @State var villager: Villager = VillagerDummy[0]
    
    var body: some View {
        HStack {
            if let url = URL(string: villager.image_url), let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:96, height: 96)
            }
            VStack {
                HStack {
                    Image(systemName: "sparkles")
                        .imageScale(.small)
                        .opacity(0.5)
                    Text("Happy Birthday")
                    Image(systemName: "sparkles")
                        .imageScale(.small)
                        .opacity(0.5)
                }
                .font(.headline)
                Text(villager.name)
                    .font(.title)
                    .fontWeight(.bold)
            }.frame(maxWidth:.infinity)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor(hexString: villager.text_color)!))
        .foregroundColor(Color(UIColor(hexString: villager.title_color)!))
    }
}

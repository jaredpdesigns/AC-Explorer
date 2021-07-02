//
//  Small.swift
//  AC BirthdaysExtension
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct Large : View {
    @State var villager: Villager = VillagerDummy[0]
    
    var body: some View {
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
            .font(.title)
            ZStack {
                if let url = URL(string: villager.nh_details.house_exterior_url), let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:120, height: 120)
                }
                if let url = URL(string: villager.image_url), let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:160, height: 160)
                }
            }
            Text(villager.name)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor(hexString: villager.text_color)!))
        .foregroundColor(Color(UIColor(hexString: villager.title_color)!))
    }
}

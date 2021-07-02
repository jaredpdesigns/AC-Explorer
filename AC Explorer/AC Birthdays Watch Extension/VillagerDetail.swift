//
//  VillagerDetail.swift
//  AC Watch Extension
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct VillagerDetail: View {
    @State var villager: Villager = VillagerDummy[0]
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                HStack {
                    Image(systemName: "sparkles")
                        .opacity(0.5)
                    Spacer()
                    Image(systemName: "sparkles")
                        .opacity(0.5)
                }
                .font(.title2)
                ImageLoader(url: villager.image_url, size: 72)
            }
            VStack {
                Text(villager.name)
                    .font(.headline)
                    .fontWeight(.bold)
                Text("\(villager.birthday_month) \(villager.birthday_day)")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color(UIColor(hexString: villager.text_color)!))
        .foregroundColor(Color(UIColor(hexString: villager.title_color)!))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct VillagerDetail_Previews: PreviewProvider {
    static var previews: some View {
        VillagerDetail()
    }
}

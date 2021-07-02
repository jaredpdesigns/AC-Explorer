//
//  VillagerList.swift
//  AC
//
//  Created by Jared Pendergraft on 6/14/21.
//

import SwiftUI

struct ListItem: View {
    let image: String
    let title: String
    let subtitle: String
    let subtitleImage: String
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            VStack(spacing: 16) {
                ImageLoader(url: image, size: 128)
                VStack(spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack {
                        Image(systemName: subtitleImage)
                            .imageScale(.small)
                        Text(subtitle)
                    }.opacity(0.5)
                }.frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(UIColor.systemFill), lineWidth: 4).opacity(0.25))
        } else {
            HStack(spacing: 16) {
                ImageLoader(url: image, size: 64)
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack(alignment: .top) {
                        Image(systemName: subtitleImage)
                            .imageScale(.small)
                            .offset(y: 2)
                        Text(subtitle)
                    }.opacity(0.5)
                }
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.accentColor)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(UIColor.systemFill), lineWidth: 4).opacity(0.25))
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(image: AnimalDummy[0].render_url, title: AnimalDummy[0].name, subtitle: AnimalDummy[0].time, subtitleImage: "clock")
    }
}

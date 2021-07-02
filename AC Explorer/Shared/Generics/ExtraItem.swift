//
//  VillagerList.swift
//  AC
//
//  Created by Jared Pendergraft on 6/14/21.
//

import SwiftUI

struct ExtraItem: View {
    let image: String
    let title: String
    let subtitle: String
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            VStack() {
                ImageLoader(url: image, size: 128)
                VStack(spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(subtitle)
                        .opacity(0.5)
                }
            }
            .padding()
            .frame(width: 200)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(UIColor.systemFill), lineWidth: 4).opacity(0.25))
        } else {
            HStack(spacing: 16) {
                ImageLoader(url: image, size: 64)
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(subtitle)
                        .opacity(0.5)
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: 480)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(UIColor.systemFill), lineWidth: 4).opacity(0.25))
        }
    }
}

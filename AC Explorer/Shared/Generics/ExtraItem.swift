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
    
    @State var isAnimating: Bool = false
    
    func animate() {
        DispatchQueue.main.async {
            withAnimation(.spring()){
                self.isAnimating.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(.spring()){
                        self.isAnimating.toggle()
                    }
                }
            }
        }
    }
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            VStack() {
                VStack {
                    ImageLoader(url: image, size: 128)
                }
                .scaleEffect(isAnimating ? 1.125:1)
                .rotationEffect(.degrees(isAnimating ? 3:0))
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
            .onTapGesture {animate()}
        } else {
            HStack(spacing: 16) {
                VStack {
                    ImageLoader(url: image, size: 64)
                }
                .scaleEffect(isAnimating ? 1.125:1)
                .rotationEffect(.degrees(isAnimating ? 3:0))
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
            .onTapGesture {animate()}
        }
    }
}

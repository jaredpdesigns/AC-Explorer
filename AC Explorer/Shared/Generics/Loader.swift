//
//  Loader.swift
//  AC Watch Extension
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct Loader: View {
    @State var isAnimating: Bool = false
    var body: some View {
        Image(systemName: "leaf")
            .font(.title2)
            .opacity(0.125)
            .rotationEffect(.degrees(isAnimating ? 240 : 0))
            .onAppear() {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)){
                        self.isAnimating.toggle()
                    }
                }
            }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}

//
//  Loader.swift
//  AC Watch Extension
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        VStack {
            Image(systemName: "leaf")
                .font(.title2)
                .opacity(0.125)
        }
        .frame(width: 32, height: 32)
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}

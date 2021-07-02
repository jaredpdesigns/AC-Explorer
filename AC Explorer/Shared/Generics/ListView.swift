//
//  ContentView.swift
//  Shared
//
//  Created by Jared Pendergraft on 6/10/21.
//

import SwiftUI

struct ListView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                    content
                }.padding()
            }
        } else {
            List {
                content
            }
            .listStyle(.plain)
        }
    }
}

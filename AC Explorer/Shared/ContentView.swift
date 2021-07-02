//
//  ContentView.swift
//  Shared
//
//  Created by Jared Pendergraft on 7/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedView: Int? = 1
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationView {
                Sidebar(selectedView: $selectedView)
                VillagersView()
            }.navigationViewStyle(DoubleColumnNavigationViewStyle())
        } else {
            TabBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

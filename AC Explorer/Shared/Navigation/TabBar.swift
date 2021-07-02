//
//  TabBar.swift
//  AC
//
//  Created by Jared Pendergraft on 6/16/21.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            NavigationView {
                VillagersView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Villagers", systemImage: "leaf")
            }
            NavigationView {
                AnimalsView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Animals", systemImage: "ladybug")
            }
            NavigationView {
                ClothingView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Clothing", systemImage: "tshirt")
            }
            NavigationView {
                ItemsView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Home Items", systemImage: "house")
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

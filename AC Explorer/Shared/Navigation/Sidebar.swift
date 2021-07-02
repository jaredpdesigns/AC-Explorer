//
//  Sidebar.swift
//  AC
//
//  Created by Jared Pendergraft on 6/16/21.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selectedView: Int?
    var body: some View {
        List(selection: $selectedView) {
            NavigationLink(
                destination: VillagersView(),
                tag: 1,
                selection: $selectedView,
                label: {
                Label("Villagers", systemImage: selectedView == 1 ? "leaf.fill": "leaf")
                    .imageScale(.small)
                    .onTapGesture {
                        selectedView = 1
                    }
            })
            NavigationLink(
                destination: AnimalsView(),
                tag: 2,
                selection: $selectedView,
                label: {
                Label("Animals", systemImage: selectedView == 2 ? "ladybug.fill": "ladybug")
                    .imageScale(.small)
                    .onTapGesture {
                        selectedView = 2
                    }
            })
            NavigationLink(
                destination: ClothingView(),
                tag: 3,
                selection: $selectedView,
                label: {
                Label("Clothing", systemImage: selectedView == 3 ? "tshirt.fill": "tshirt")
                    .imageScale(.small)
                    .onTapGesture {
                        selectedView = 3
                    }
            })
            NavigationLink(
                destination: ItemsView(),
                tag: 4,
                selection: $selectedView,
                label: {
                Label("Home Items", systemImage: selectedView == 4 ? "house.fill": "house")
                    .imageScale(.small)
                    .onTapGesture {
                        selectedView = 4
                    }
            })
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Explore")
    }
}

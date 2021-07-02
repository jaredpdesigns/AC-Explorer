//
//  Fish.swift
//  AC
//
//  Created by Jared Pendergraft on 6/16/21.
//

import SwiftUI

struct VillagersView: View {
    @State var arr: [Villager] = []
    @State var loaded: Bool = false
    @State private var query = ""
    var searchResults: [Villager] {
        if query.isEmpty {
            return arr
        } else {
            return arr.filter { $0.name.contains(query) }
        }
    }
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack {
                if query != "" && searchResults.isEmpty {
                    Spacer()
                    Label("No results found", systemImage: "exclamationmark.triangle")
                        .imageScale(.small)
                        .opacity(0.5)
                    Spacer()
                } else {
                    if searchResults.isEmpty {
                        Spacer()
                        Loader()
                        Spacer()
                    } else {
                        ListView {
                            ForEach(searchResults) { item in
                                DestinationView(image: item.image_url, imageSecondary: item.nh_details.house_exterior_url, title: item.name, subtitle: "\(item.birthday_month) \(item.birthday_day)", subtitleImage: "gift", quote: item.quote, variationsQuery: [Query(label: "Favorite Outfit", query: "/clothing/\(item.nh_details.clothing)")], itemsQuery: [Query(label: "House Flooring", query: "/interior/\(item.nh_details.house_flooring)"), Query(label: "House Wallpaper", query: "/interior/\(item.nh_details.house_wallpaper)")])
                            }
                        }
                    }
                }
            }
            .navigationTitle("Villagers")
            .onAppear{
                Api().getVillagers{(response) in
                    self.arr = response
                    self.loaded = true
                }
            }
            .searchable(text: $query, prompt: "Search…") {
                if query != "" && UIDevice.current.userInterfaceIdiom == .phone {
                    ForEach(searchResults) { result in
                        Text("Looking for **\(result.name)**?").searchCompletion(result.name)
                    }
                }
            }
        } else {
            VStack {
                if arr.isEmpty {
                    Spacer()
                    Loader()
                    Spacer()
                } else {
                    ListView {
                        ForEach(arr) { item in
                            DestinationView(image: item.image_url, imageSecondary: item.nh_details.house_exterior_url, title: item.name, subtitle: "\(item.birthday_month) \(item.birthday_day)", subtitleImage: "gift", quote: item.quote, variationsQuery: [Query(label: "Favorite Outfit", query: "/clothing/\(item.nh_details.clothing)")], itemsQuery: [Query(label: "House Flooring", query: "/interior/\(item.nh_details.house_flooring)"), Query(label: "House Wallpaper", query: "/interior/\(item.nh_details.house_wallpaper)")])
                        }
                    }
                }
            }
            .navigationTitle("Villagers")
            .onAppear{
                Api().getVillagers{(response) in
                    self.arr = response
                    self.loaded = true
                }
            }
        }
    }
}

struct VillagersView_Previews: PreviewProvider {
    static var previews: some View {
        VillagersView()
    }
}

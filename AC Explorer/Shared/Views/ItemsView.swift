//
//  item.swift
//  AC
//
//  Created by Jared Pendergraft on 6/16/21.
//

import SwiftUI

struct ItemsView: View {
    @State private var selection = "Furniture"
    var selectionOptions = ["Furniture", "Interior Items"]
    @State var furniture: [Variations] = []
    @State var items: [Item] = []
    @State private var query = ""
    
    var searchResultsFurniture: [Variations] {
        if query.isEmpty {
            return furniture
        } else {
            return furniture.filter { $0.name.contains(query) }
        }
    }
    
    var searchResultsItems: [Item] {
        if query.isEmpty {
            return items
        } else {
            return items.filter { $0.name.contains(query) }
        }
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack(spacing: 8) {
                Picker(selection: $selection, label: Text("Select filter")) {
                    ForEach(selectionOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 320)
                if selection == "Furniture" {
                    if query != "" && searchResultsFurniture.isEmpty {
                        Spacer()
                        Label("No results found", systemImage: "exclamationmark.triangle")
                            .imageScale(.small)
                            .opacity(0.5)
                        Spacer()
                    } else {
                        if searchResultsFurniture.isEmpty {
                            Spacer()
                            Loader()
                            Spacer()
                        } else {
                            ListView {
                                ForEach(searchResultsFurniture, id: \.self) { item in
                                    DestinationView(image: item.variations[0].image_url, title: item.name, subtitle: item.category, subtitleImage: "tag", buy: item.buy.isEmpty ? nil:item.buy[0])
                                }
                            }
                        }
                    }
                }
                if selection == "Interior Items" {
                    if query != "" && searchResultsItems.isEmpty {
                        Spacer()
                        Label("No results found", systemImage: "exclamationmark.triangle")
                            .imageScale(.small)
                            .opacity(0.5)
                        Spacer()
                    } else {
                        if searchResultsItems.isEmpty {
                            Spacer()
                            Loader()
                            Spacer()
                        } else {
                            ListView {
                                ForEach(searchResultsItems, id: \.self) { item in
                                    DestinationView(image: item.image_url, title: item.name, subtitle: item.category, subtitleImage: "tag", buy: item.buy.isEmpty ? nil:item.buy[0])
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home Items")
            .onAppear{
                Api().getVariations(query: "/furniture"){(response) in
                    self.furniture = response
                }
                Api().getItems(query: "/interior"){(response) in
                    self.items = response
                }
            }
            .searchable(text: $query, prompt: "Search…") {
                if query != "" && UIDevice.current.userInterfaceIdiom == .phone {
                    if selection == "Furniture" {
                        ForEach(searchResultsFurniture, id: \.self) { result in
                            Text("Looking for **\(result.name)**?").searchCompletion(result.name)
                        }
                    }
                    if selection == "Interior Items" {
                        ForEach(searchResultsItems, id: \.self) { result in
                            Text("Looking for **\(result.name)**?").searchCompletion(result.name)
                        }
                    }
                    
                }
            }
        } else {
            VStack(spacing: 8) {
                Picker(selection: $selection, label: Text("Select filter")) {
                    ForEach(selectionOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 320)
                if selection == "Furniture" {
                    if furniture.isEmpty {
                        Spacer()
                        Loader()
                        Spacer()
                    } else {
                        ListView {
                            ForEach(furniture, id: \.self) { item in
                                DestinationView(image: item.variations[0].image_url, title: item.name, subtitle: item.category, subtitleImage: "tag")
                            }
                        }
                    }
                }
                if selection == "Interior Items" {
                    if items.isEmpty {
                        Spacer()
                        Loader()
                        Spacer()
                    } else {
                        ListView {
                            ForEach(items, id: \.self) { item in
                                DestinationView(image: item.image_url, title: item.name, subtitle: item.category, subtitleImage: "tag")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home Items")
            .onAppear{
                Api().getVariations(query: "/furniture"){(response) in
                    self.furniture = response
                }
                Api().getItems(query: "/interior"){(response) in
                    self.items = response
                }
            }
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}

//
//  Fish.swift
//  AC
//
//  Created by Jared Pendergraft on 6/16/21.
//

import SwiftUI

struct ClothingView: View {
    @State var arr: [Variations] = []
    @State private var query = ""
    var searchResults: [Variations] {
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
                            ForEach(searchResults, id: \.self) { item in
                                DestinationView(image: item.variations[0].image_url, title: item.name, subtitle: item.category, subtitleImage: "tag", buy: item.buy.isEmpty ? nil:item.buy[0])
                            }
                        }
                    }
                }
            }
            .navigationTitle("Clothing")
            .onAppear{
                Api().getVariations(query: "/clothing"){(response) in
                    self.arr = response
                }
            }
            .searchable(text: $query, prompt: "Search…") {
                if query != "" && UIDevice.current.userInterfaceIdiom == .phone {
                    ForEach(searchResults, id: \.self) { result in
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
                        ForEach(arr, id: \.self) { item in
                            DestinationView(image: item.variations[0].image_url, title: item.name, subtitle: item.category, subtitleImage: "tag", buy: item.buy[0])
                        }
                    }
                }
            }
            .navigationTitle("Clothing")
            .onAppear{
                Api().getVariations(query: "/clothing"){(response) in
                    self.arr = response
                }
            }
        }
    }
}

struct ClothingView_Previews: PreviewProvider {
    static var previews: some View {
        ClothingView()
    }
}

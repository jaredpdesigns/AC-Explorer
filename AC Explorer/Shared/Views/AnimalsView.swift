//
//  item.swift
//  AC
//
//  Created by Jared Pendergraft on 6/16/21.
//

import SwiftUI

struct AnimalsView: View {
    @State private var selection = "Bugs"
    var selectionOptions = ["Bugs", "Fish", "Sea Creatures"]
    @State var bugs: [Animal] = []
    @State var fish: [Animal] = []
    @State var seaCreatures: [Animal] = []
    @State private var query = ""
    
    var searchResultsBugs: [Animal] {
        if query.isEmpty {
            return bugs
        } else {
            return bugs.filter { $0.name.contains(query)
            }
        }
    }
    var searchResultsFish: [Animal] {
        if query.isEmpty {
            return fish
        } else {
            return fish.filter { $0.name.contains(query)
            }
        }
    }
    var searchResultsSeaCreatures: [Animal] {
        if query.isEmpty {
            return seaCreatures
        } else {
            return seaCreatures.filter { $0.name.contains(query)
            }
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
                if selection == "Bugs" {
                    if query != "" && searchResultsBugs.isEmpty {
                        Spacer()
                        Label("No results found", systemImage: "exclamationmark.triangle")
                            .imageScale(.small)
                            .opacity(0.5)
                        Spacer()
                    } else {
                        if searchResultsBugs.isEmpty {
                            Spacer()
                            Loader()
                            Spacer()
                        } else {
                            ListView {
                                ForEach(searchResultsBugs, id: \.self) { item in
                                    DestinationView(image: item.render_url, title: item.name, subtitle: item.location!, subtitleImage: "location.fill", quote: item.catchphrases[0])
                                }
                            }
                        }
                    }
                }
                if selection == "Fish" {
                    if query != "" && searchResultsFish.isEmpty {
                        Spacer()
                        Label("No results found", systemImage: "exclamationmark.triangle")
                            .imageScale(.small)
                            .opacity(0.5)
                        Spacer()
                    } else {
                        if searchResultsFish.isEmpty {
                            Spacer()
                            Loader()
                            Spacer()
                        } else {
                            ListView {
                                ForEach(searchResultsFish, id: \.self) { item in
                                    DestinationView(image: item.render_url, title: item.name, subtitle: item.location!, subtitleImage: "location.fill", quote: item.catchphrases[0])
                                }
                            }
                        }
                    }
                }
                if selection == "Sea Creatures" {
                    if query != "" && searchResultsSeaCreatures.isEmpty {
                        Spacer()
                        Label("No results found", systemImage: "exclamationmark.triangle")
                            .imageScale(.small)
                            .opacity(0.5)
                        Spacer()
                    } else {
                        if searchResultsSeaCreatures.isEmpty {
                            Spacer()
                            Loader()
                            Spacer()
                        } else {
                            ListView {
                                ForEach(searchResultsSeaCreatures, id: \.self) { item in
                                    DestinationView(image: item.render_url, title: item.name, subtitle: item.time, subtitleImage: "clock", quote: item.catchphrases[0])
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Animals")
            .onAppear{
                Api().getAnimals(query: "/bugs"){(response) in
                    self.bugs = response
                }
                Api().getAnimals(query: "/fish"){(response) in
                    self.fish = response
                }
                Api().getAnimals(query: "/sea"){(response) in
                    self.seaCreatures = response
                }
            }
            .searchable(text: $query, prompt: "Search…") {
                if query != "" {
                    if selection == "Bugs" {
                        ForEach(searchResultsBugs, id: \.self) { result in
                            Text("\(result.name)?").searchCompletion(result.name)
                        }
                    }
                    if selection == "Fish" {
                        ForEach(searchResultsFish, id: \.self) { result in
                            Text("\(result.name)?").searchCompletion(result.name)
                        }
                    }
                    if selection == "Sea Creatures" {
                        ForEach(searchResultsSeaCreatures, id: \.self) { result in
                            Text("\(result.name)?").searchCompletion(result.name)
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
                if selection == "Bugs" {
                    if bugs.isEmpty {
                        Spacer()
                        Loader()
                        Spacer()
                    } else {
                        ListView {
                            ForEach(bugs, id: \.self) { item in
                                DestinationView(image: item.render_url, title: item.name, subtitle: item.location!, subtitleImage: "location.fill", quote: item.catchphrases[0])
                            }
                        }
                    }
                }
                if selection == "Fish" {
                    if fish.isEmpty {
                        Spacer()
                        Loader()
                        Spacer()
                    } else {
                        ListView {
                            ForEach(fish, id: \.self) { item in
                                DestinationView(image: item.render_url, title: item.name, subtitle: item.location!, subtitleImage: "location.fill", quote: item.catchphrases[0])
                            }
                        }
                    }
                }
                if selection == "Sea Creatures" {
                    if seaCreatures.isEmpty {
                        Spacer()
                        Loader()
                        Spacer()
                    } else {
                        ListView {
                            ForEach(seaCreatures, id: \.self) { item in
                                DestinationView(image: item.render_url, title: item.name, subtitle: item.time, subtitleImage: "clock", quote: item.catchphrases[0])
                            }
                        }
                    }
                }
            }
            .navigationTitle("Animals")
            .onAppear{
                Api().getAnimals(query: "/bugs"){(response) in
                    self.bugs = response
                }
                Api().getAnimals(query: "/fish"){(response) in
                    self.fish = response
                }
                Api().getAnimals(query: "/sea"){(response) in
                    self.seaCreatures = response
                }
            }
        }
    }
}

struct AnimalsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsView()
    }
}

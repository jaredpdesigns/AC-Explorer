//
//  ContentView.swift
//  AC Watch Extension
//
//  Created by Jared Pendergraft on 6/30/21.
//

import SwiftUI

struct ContentView: View {
    @State var villagers: [Villager] = []
    @State var loaded: Bool = false
    
    let month = Calendar.current.dateComponents([.month], from: Date()).month!
    
    var body: some View {
        GeometryReader { geometry in
            if loaded {
                ScrollView {
                    ForEach(villagers) {item in
                        VillagerDetail(villager: item)
                            .frame(height: geometry.size.height + geometry.safeAreaInsets.top)
                    }
                }
            } else {
                VStack {
                    Image(systemName: "leaf")
                        .font(.title)
                        .opacity(0.25)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarTitle("AC Birthdays")
        .frame(maxHeight: .infinity)
        .onAppear {
            Api().getVillagersMonth(month: "\(month)"){(response) in
                let sortedVillagers = response.sorted {
                    Double($0.birthday_day)! < Double($1.birthday_day)!
                }
                self.villagers = sortedVillagers
                self.loaded = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

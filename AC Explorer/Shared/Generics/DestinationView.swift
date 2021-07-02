//
//  ContentView.swift
//  Shared
//
//  Created by Jared Pendergraft on 6/10/21.
//

import SwiftUI

struct DestinationView: View {
    let image: String
    @State var imageSecondary: String?
    let title: String
    let subtitle: String
    let subtitleImage: String
    @State var quote: String?
    @State var variationsQuery: [Query]?
    @State var itemsQuery: [Query]?
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationLink(destination: DetailView(image: image, imageSecondary: imageSecondary, title: title, subtitle: subtitle, subtitleImage: subtitleImage, quote: quote, variationsQuery: variationsQuery, itemsQuery: itemsQuery)) {
                ListItem(image: image, title: title, subtitle: subtitle, subtitleImage: subtitleImage)
            }.buttonStyle(PlainButtonStyle())
        } else {
            if #available(iOS 15.0, *) {
                ZStack(alignment: .leading) {
                    NavigationLink(destination: DetailView(image: image, imageSecondary: imageSecondary, title: title, subtitle: subtitle, subtitleImage: subtitleImage, quote: quote, variationsQuery: variationsQuery, itemsQuery: itemsQuery)) {
                        EmptyView()
                    }.opacity(0)
                    ListItem(image: image, title: title, subtitle: subtitle, subtitleImage: subtitleImage)
                }.listRowSeparator(.hidden)
            } else {
                ZStack(alignment: .leading) {
                    NavigationLink(destination: DetailView(image: image, imageSecondary: imageSecondary, title: title, subtitle: subtitle, subtitleImage: subtitleImage, quote: quote, variationsQuery: variationsQuery, itemsQuery: itemsQuery)) {
                        EmptyView()
                    }.opacity(0)
                    ListItem(image: image, title: title, subtitle: subtitle, subtitleImage: subtitleImage)
                }
            }
        }
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(image: VillagerDummy[0].image_url, title: VillagerDummy[0].name, subtitle: "\(VillagerDummy[0].birthday_month) \(VillagerDummy[0].birthday_day)", subtitleImage: "gift", quote: VillagerDummy[0].quote)
    }
}

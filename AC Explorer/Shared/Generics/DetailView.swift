//
//  VillagerList.swift
//  AC
//
//  Created by Jared Pendergraft on 6/14/21.
//

import SwiftUI

struct DetailView: View {
    let image: String
    @State var imageSecondary: String?
    let title: String
    let subtitle: String
    let subtitleImage: String
    @State var quote: String?
    @State var variationsQuery: [Query]? = []
    @State var variationsHolder: [QueryResultVariations] = []
    @State var itemsQuery: [Query]? = []
    @State var itemsHolder: [QueryResultItem] = []
    @State var buy: Buy?
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16)  {
                    ZStack {
                        if imageSecondary != nil {
                            ImageLoader(url: imageSecondary!, size: 200)
                        }
                        ImageLoader(url: image, size: 240)
                    }
                    VStack(spacing: 32) {
                        VStack(spacing: 8) {
                            Text(title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            HStack {
                                Image(systemName: subtitleImage)
                                    .imageScale(.small)
                                Text(subtitle)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }.opacity(0.5)
                        }
                        if quote != nil {
                            VStack {
                                Text("”\(quote!)“")
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .frame(maxWidth: 480)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(UIColor.systemFill), lineWidth: 4).opacity(0.25))
                        }
                        if buy != nil {
                            VStack {
                                HStack {
                                    Image(systemName: "cart")
                                        .imageScale(.small)
                                        .opacity(0.5)
                                    Text("\(buy!.price) \(buy!.currency)")
                                }
                            }
                            .padding()
                            .frame(maxWidth: 480)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(UIColor.systemFill), lineWidth: 4).opacity(0.25))
                        }
                    }
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                            ForEach(variationsHolder, id: \.self) { item in
                                ExtraItem(image: item.response.variations[0].image_url, title: item.label, subtitle: item.response.name)
                            }
                            ForEach(itemsHolder, id: \.self) { item in
                                ExtraItem(image: item.response.image_url, title: item.label, subtitle: item.response.name)
                            }
                        }
                    } else {
                        ForEach(variationsHolder, id: \.self) { item in
                            ExtraItem(image: item.response.variations[0].image_url, title: item.label, subtitle: item.response.name)
                        }
                        ForEach(itemsHolder, id: \.self) { item in
                            ExtraItem(image: item.response.image_url, title: item.label, subtitle: item.response.name)
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity)
            .onAppear{
                if variationsQuery != nil && variationsHolder.isEmpty  {
                    for item in variationsQuery! {
                        Api().getVariationsSingle(query: item.query){(response) in
                            self.variationsHolder.insert(QueryResultVariations(label: item.label, response: response), at: self.variationsHolder.endIndex)
                        }
                    }
                }
                if itemsQuery != nil && itemsHolder.isEmpty {
                    for item in itemsQuery! {
                        Api().getItemsSingle(query: item.query){(response) in
                            self.itemsHolder.insert(QueryResultItem(label: item.label, response: response), at: self.itemsHolder.endIndex)
                        }
                    }
                }
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: AnimalDummy[0].render_url, title: AnimalDummy[0].name, subtitle: AnimalDummy[0].time, subtitleImage: "clock")
    }
}

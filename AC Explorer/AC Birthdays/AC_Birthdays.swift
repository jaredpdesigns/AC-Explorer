//
//  AC_Birthdays.swift
//  AC Birthdays
//
//  Created by Jared Pendergraft on 6/29/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> VillagerEntry {
        VillagerEntry(date: Date(), villager: VillagerDummy[0])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (VillagerEntry) -> Void) {
        
        let day = Calendar.current.dateComponents([.day, .month], from: Date()).day!
        let month = Calendar.current.dateComponents([.day, .month], from: Date()).month!
        
        Api().getBirthday(day: "\(day)", month: "\(month)"){(response) in
            var entry: VillagerEntry
            if context.isPreview {
                entry = VillagerEntry(date: Date(), villager: VillagerDummy[0])
                completion(entry)
            } else {
                entry = VillagerEntry(date: Date(), villager: response)
                completion(entry)
            }
        }
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<VillagerEntry>) -> Void) {
        
        let day = Calendar.current.dateComponents([.day, .month], from: Date()).day!
        let month = Calendar.current.dateComponents([.day, .month], from: Date()).month!
        
        Api().getBirthday(day: "\(day)", month: "\(month)"){(response) in
            var entry: VillagerEntry
            entry = VillagerEntry(date: Date(), villager: response)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct VillagerEntry: TimelineEntry {
    var date: Date
    var villager: Villager
}

struct BirthdayView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            Small(villager: entry.villager)
        case .systemMedium:
            Medium(villager: entry.villager)
        case .systemLarge:
            Large(villager: entry.villager)
        case .systemExtraLarge:
            Large(villager: entry.villager)
        @unknown default:
            Loader()
        }
    }
}

@main
struct AC_Birthdays: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "AC_Birthdays",
            provider: Provider()
        ) { entry in
            BirthdayView(entry: entry)
        }
        .configurationDisplayName("Animal Crossing Birthdays")
        .description("Who’s birthday is it today?")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct AC_Birthdays_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayView(entry: VillagerEntry(date: Date(), villager: VillagerDummy[0]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

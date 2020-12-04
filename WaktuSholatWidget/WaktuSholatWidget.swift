//
//  WaktuSholatWidget.swift
//  WaktuSholatWidget
//
//  Created by Fandrian Rhamadiansyah on 25/10/20.
//

import WidgetKit
import SwiftUI

//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date())
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date())
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//}
//
//struct WaktuSholatWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}

@main
struct WaktuSholatWidget: Widget {
    let kind: String = "WaktuSholatWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WaktuSholatTimelineProvider()) { entry in
            WaktuSholatEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WaktuSholatWidget_Previews: PreviewProvider {
    static var previews: some View {
        WaktuSholatEntryView(entry: WaktuSholatEntry.stub)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

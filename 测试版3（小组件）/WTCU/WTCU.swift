//
//  WTCU.swift
//  WTCU
//
//  Created by mac on 2023/1/2.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        struct GameStatusEntry:TimelineEntry {
            var date:Date
            var gameStatus:String
            let url = URL(string: "https://wtcu.github.io/images/logo.jpeg")
        }
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}



struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WTCUEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct WTCU: Widget {
    let kind: String = "WTCU"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WTCUEntryView(entry: entry)
        }
        .configurationDisplayName("WTCU专用组件")
        .description("WTCU内部人员专用小组件，用于识别身份")
    }
}

// 占位符小组件配置失败
// struct GameStatusProvider:TimelineProvider {
//     func placeholder(in context:Context) ->SimpleEntry {GameStatusEntry(date:Date(), gameStatus:"—")
//     }
// }


struct WTCU_Previews: PreviewProvider {
    static var previews: some View {
        WTCUEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

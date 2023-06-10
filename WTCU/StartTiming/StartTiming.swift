//
//  StartTiming.swift
//  StartTiming
//
//  Created by mac on 2023/6/10.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let bootTime = Date().addingTimeInterval(-1 * ProcessInfo.processInfo.systemUptime)
        let entry = SimpleEntry(date: Date(), configuration: ConfigurationIntent(), systemBootTime: bootTime)
        return entry
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let bootTime = Date().addingTimeInterval(-1 * ProcessInfo.processInfo.systemUptime)
        let entry = SimpleEntry(date: Date(), configuration: configuration, systemBootTime: bootTime)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let bootTime = Date().addingTimeInterval(-1 * ProcessInfo.processInfo.systemUptime)
            let entry = SimpleEntry(date: entryDate, configuration: configuration, systemBootTime: bootTime)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let systemBootTime: Date
}

struct StartTimingEntryView : View {
    var entry: Provider.Entry

    func formattedDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日 HH:mm"
        return dateFormatter.string(from: date)
    }

    var body: some View {
        VStack {
            Text(formattedDateString(entry.date))
            Text("开机时间: \(entry.systemBootTime, style: .relative) ")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 设置 frame
        .background(Color.blue) // 添加背景颜色可以更好的看到文本居中对齐的效果
        .foregroundColor(.white)
        .font(.title)
        .multilineTextAlignment(.center) // 设置文字对齐方式
        .padding() // 添加内边距
        .cornerRadius(10) // 添加圆角
        .shadow(radius: 5) // 添加阴影
    }
}


//StartTiming
@main
struct StartTiming: Widget {
    let kind: String = "StartTiming"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            StartTimingEntryView(entry: entry)
        }
        .configurationDisplayName("开机时间")
        .description("建议一段时间重启电脑")
    }
}

struct StartTiming_Previews: PreviewProvider {
    static var previews: some View {
        StartTimingEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), systemBootTime: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

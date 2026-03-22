import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: Date())], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct time_widgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 2) {
            Text("しなもん")
                .font(.system(size: 22, weight: .ultraLight))
                .foregroundColor(.white)
                .tracking(2)
                .opacity(0.45)

            Text(entry.date, style: .time)
                .font(.custom("Didot", size: 52))
                .foregroundColor(.white)
                .tracking(-1)
                .opacity(0.55)
        }
    }
}

struct time_widget: Widget {
    let kind: String = "time_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, *) {
                time_widgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        Image("lily")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
            } else {
                time_widgetEntryView(entry: entry)
                    .padding()
                    .background(Image("lily").resizable().aspectRatio(contentMode: .fill))
            }
        }
        .configurationDisplayName("しなもん")
        .description("time widget")
    }
}

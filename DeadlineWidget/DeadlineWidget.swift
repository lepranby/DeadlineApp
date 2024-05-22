//
//  DeadlineWidget.swift
//  DeadlineWidget
//
//  Created by Aleksej Shapran on 08.04.24.
//

import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let entry = SimpleEntry(date: .now)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DeadlineWidgetEntryView : View {

    var entry: Provider.Entry

    // MARK: Fetch only 3 last tasks

    @Query (taskDescriptor, animation: .snappy) private var activeList: [Task]

    var body: some View {

        VStack {
            ForEach(activeList) { task in
                HStack(spacing: 10) {
                    Button (intent: ToggleButton(id: task.taskID), label: {
                        Image(systemName: "circle")
                    })
                    .font(.callout)
                    .tint(task.priority.color.gradient)
                    .buttonBorderShape(.circle)

                    Text(task.task)
                        .font(.callout)
                        .lineLimit(1)

                    Spacer(minLength: 0)
                }
                .transition(.push(from: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay {
            if activeList .isEmpty {
                Text("No tasks")
                    .font(.callout)
                    .transition(.push(from: .bottom))
            }
        }
    }

    static var taskDescriptor: FetchDescriptor<Task> {
        let predicate = #Predicate<Task> { !$0.isCompleted }
        let sort = [SortDescriptor(\Task.lastUpdated, order: .reverse)]
        var descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)

        descriptor.fetchLimit = 3

        return descriptor
    }

}

struct DeadlineWidget: Widget {

    let kind: String = "DeadlineWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DeadlineWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
            // MARK: Setup SwiftData
                .modelContainer(for: Task.self)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Deadline")
        .description("This is an Deadlines task widget.")
    }
}

// MARK: Update task status

struct ToggleButton: AppIntent {
    
    static var title: LocalizedStringResource = .init(stringLiteral: "Toggle's Task Status")

    @Parameter(title: "Task ID")
    var id: String

    init() {

    }

    init(id: String) {
        self.id = id
    }

    func perform() async throws -> some IntentResult {

        let context = try ModelContext(.init(for: Task.self))
        let descriptor = FetchDescriptor(predicate: #Predicate<Task> { $0.taskID == id })

        if let task = try context.fetch(descriptor).first {
            task.isCompleted = true
            task.lastUpdated = .now
            try context.save()
        }

        return .result()
    }
}

#Preview(as: .systemSmall) {
    DeadlineWidget()
} timeline: {
    SimpleEntry(date: .now)
}

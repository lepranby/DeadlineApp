//  TaskRow.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI
import WidgetKit

struct TaskRow: View {

    @Bindable var task: Task
    @FocusState private var isActive: Bool
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var phase
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack (spacing: 8) {
            if !isActive && !task.task.isEmpty {
                Button(action: {
                    task.isCompleted.toggle()
                    task.lastUpdated = .now
                    haptic()
                    WidgetCenter.shared.reloadAllTimelines()
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .padding(3)
                        .contentShape(.rect)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                        .contentTransition(.symbolEffect(.replace))
                }
            }
            TextField("", text: $task.task)
                .strikethrough(task.isCompleted)
                .foregroundStyle(colorScheme == .dark ? .white : .black.opacity(0.8))
                .focused($isActive)
                .scrollDismissesKeyboard(.immediately)
            if !isActive && !task.task.isEmpty {
                Menu {
                    ForEach (Priority.allCases, id: \.rawValue) { priority in
                        Button {
                            task.priority = priority
                        } label: {
                            HStack {
                                Text(priority.rawValue)
                                if task.priority == priority { Image(systemName: "checkmark") }
                            }
                        }

                    }
                } label: {
                    Image(systemName: "circle.fill")
                        .font(.title2)
                        .padding(3)
                        .contentShape(.rect)
                        .foregroundStyle(task.priority.color.gradient)
                }
            }
        }
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
        .animation(.snappy, value: isActive)
        .onAppear {
            isActive = task.task.isEmpty
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("", systemImage: "trash") {
                context.delete(task)
                WidgetCenter.shared.reloadAllTimelines()
            }
            .tint(.red)
        }
        .onSubmit (of: .text) {
            if task.task.isEmpty {
                context.delete(task)
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .onChange(of: phase) { oldValue, newValue in
            if newValue != .active && task.task.isEmpty {
                context.delete(task)
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .task {
            task.isCompleted = task.isCompleted
        }
    }
}

#Preview {
    ContentView()
}

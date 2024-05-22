//  Home.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI
import SwiftData

struct Home: View {

    // MARK: Active jobs
    @Query(filter: #Predicate<Task> { !$0.isCompleted }, sort: [SortDescriptor(\Task.lastUpdated, order: .reverse)], animation: .snappy) private var activeList: [Task]

    // MARK: Env settings
    @Environment(\.colorScheme) private var scheme
    @Environment(\.modelContext) private var context
    @AppStorage("Username") private var username: String = ""

    var body: some View {
        VStack {
            if activeList.isEmpty {
                ContentUnavailableView("No any tasks yet\nTap \(Image(systemName: "plus.circle")) to add new", systemImage: "xmark.circle").padding()
            } else {
                List {
                    Section (activeList.isEmpty ? "" : badge) {
                        ForEach(activeList) {
                            TaskRow(task: $0)
                        }
                    }
                }
            }
        }
        .background(.backgroundForm)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if !username.isEmpty {
                    VStack (alignment: .leading, spacing: 0) {
                        Text("Let's plan!").font(.footnote).fontWeight(.regular).foregroundStyle(.primary)
                        Text(username).font(.caption).fontWeight(.light).foregroundStyle(.secondary)
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    let task = Task(task: "", priority: .normal)
                    context.insert(task)
                }, label: {
                    Image(systemName: "circle.badge.plus")
                        .resizable()
                        .frame(width: 28, height: 24)
                        .fontWeight(.light)
                        .foregroundStyle(scheme == .dark ? .white : .black)
                })
            }
        }
    }

    // MARK: Badge
    var badge: String {
        let count = activeList.count
        return count == 0 ? "Tasks" : "Tasks (\(count))"
    }

}

#Preview {
    ContentView()
}

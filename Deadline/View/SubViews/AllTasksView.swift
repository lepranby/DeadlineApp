//  AllTasksView.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI
import SwiftData

struct AllTasksView: View {

    @Binding var showAll: Bool
    @Query private var allTasks: [Task]
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("AppearanceTitle") private var appearanceTitle: Bool = true

    var body: some View {
        NavigationStack {
            VStack {
                if allTasks .isEmpty {
                    ContentUnavailableView("No any tasks here.", systemImage: "xmark.circle").padding()
                } else {
                    List {
                        ForEach(allTasks) {
                            TaskRow(task: $0)
                        }
                    }.listSectionSpacing(0)
                }
            }
            .navigationTitle("All Tasks")
            .navigationBarTitleDisplayMode(appearanceTitle ? .inline : .large)
        }
    }
}

#Preview {
    ContentView()
}

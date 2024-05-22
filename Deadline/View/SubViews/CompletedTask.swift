//  CompletedTask.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI
import SwiftData

struct CompletedTask: View {

    @Binding var showAll: Bool
    @Query private var completedList: [Task]
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("AppearanceTitle") private var appearanceTitle: Bool = true

    @Environment(\.modelContext) private var context

    init (showAll: Binding<Bool>) {

        let predicate = #Predicate<Task> { $0.isCompleted }
        let sort = [SortDescriptor(\Task.lastUpdated, order: .reverse)]
        let descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)

        //        if !showAll.wrappedValue {
        //            descriptor.fetchLimit = 12
        //        }

        _completedList = Query (descriptor, animation: .snappy)
        _showAll = showAll

    }

    var body: some View {
        NavigationStack {
            VStack {
                if completedList .isEmpty {
                    ContentUnavailableView("Not a single task has been\ncompleted yet. Once you complete a task,it will\nappear here.", systemImage: "xmark.circle").padding()
                } else {
                    List {
                        ForEach(completedList) {
                            TaskRow(task: $0)
                        }
                    }.listSectionSpacing(0)
                }
            }
            .navigationTitle("Completed")
            .navigationBarTitleDisplayMode(appearanceTitle ? .inline : .large)
        }
    }
}

#Preview {
    ContentView()
}


/// HEADEr for view
//header: {
//   HStack {
//       Text("Tasks")
//       Spacer(minLength: 0)
//       if showAll {
//           Button("LESS") {
//               withAnimation(.bouncy) {
//                   showAll = false
//               }
//           }.font(.footnote).foregroundColor(colorScheme == .dark ? .white : .black)
//       }
//   }.font(.callout)
//} footer: {
//   if completedList.count == 12 && !showAll {
//       HStack {
//           Text("Last 12").foregroundStyle(.gray)
//           Spacer(minLength: 0)
//           Button("MORE") {
//               withAnimation(.bouncy) {
//                   showAll = true
//               }
//           }.foregroundColor(colorScheme == .dark ? .white : .black)
//       }.font(.footnote)
//   }
//}

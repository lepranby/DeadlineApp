//  CompletedTaskView.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI
import SwiftData

struct CompletedTaskView: View {

    @Query private var completedList: [Task]

    @State private var showAll: Bool = false
    @AppStorage("AppearanceTitle") private var appearanceTitle: Bool = true
    @Environment(\.colorScheme) private var scheme
    @AppStorage("Username") private var username: String = ""

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, content: {
                VStack (alignment: .leading, spacing: 8) {
                    HStack (spacing: 8) {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.green)
                            .font(.title2)
                        RoundedRectangle(cornerRadius: 8).fill(scheme == .dark ? .darkSection : .white)
                            .frame(width: UIScreen.main.bounds.width - 90, height: 40)
                            .overlay {
                                HStack {
                                    NavigationLink { CompletedTask(showAll: $showAll) } label: { Text("See only completed tasks") }
                                    Spacer()
                                }
                                .foregroundStyle(Color.primary)
                                .frame(width: UIScreen.main.bounds.width - 120, height: 38)
                            }
                        Image(systemName: "chevron.compact.right")
                            .padding(.horizontal, 4)
                    }.padding(.horizontal, 20)
                    HStack (spacing: 8) {
                        Image(systemName: "circle")
                            .foregroundStyle(LinearGradient(colors: [.blue, .gray], startPoint: .top, endPoint: .bottom))
                            .font(.title2)
                        RoundedRectangle(cornerRadius: 8).fill(scheme == .dark ? .darkSection : .white)
                            .frame(width: UIScreen.main.bounds.width - 90, height: 40)
                            .overlay {
                                HStack {
                                    NavigationLink { AllTasksView(showAll: $showAll) } label: { Text("See all") }
                                    Spacer()
                                }
                                .foregroundStyle(Color.primary)
                                .frame(width: UIScreen.main.bounds.width - 120, height: 38)
                            }
                        Image(systemName: "chevron.compact.right")
                            .padding(.horizontal, 4)
                    }.padding(.horizontal, 20)
                    Spacer()
                }.padding(.horizontal).padding(.vertical, 32)
            })
            .background(.backgroundForm)
            .navigationTitle("Archive")
            .navigationBarTitleDisplayMode(appearanceTitle ? .inline : .large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !username.isEmpty {
                        VStack (alignment: .leading, spacing: 0) {
                            Text("Let's manage!").font(.footnote).fontWeight(.regular).foregroundStyle(.primary)
                            Text(username).font(.caption).fontWeight(.light).foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CompletedTaskView()
}

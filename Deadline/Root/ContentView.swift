//  ContentView.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI

struct ContentView: View {

    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Active", systemImage: "circle.circle")
                }
            CompletedTaskView()
                .tabItem {
                    Label("Archive", systemImage: "archivebox")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstTime, content: {
            IntroScreen()
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}

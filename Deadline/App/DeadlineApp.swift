//  DeadlineApp.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI
import SwiftData

@main struct DeadlineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Task.self)
    }
}

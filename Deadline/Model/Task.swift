//  Task.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI
import SwiftData

@Model class Task {

    private(set) var taskID: String = UUID().uuidString
    var task: String
    var isCompleted: Bool = false
    var priority: Priority = Priority.normal
    var lastUpdated: Date = Date.now

    init(task: String, priority: Priority) {
        self.task = task
        self.priority = priority
    }
    
}

enum Priority: String, Codable, CaseIterable {

    case normal = "Normal"
    case ordinary = "Ordinary"
    case important = "Important"

    var color: Color {
        switch self {
        case .normal: return .teal
        case .ordinary: return .green
        case .important: return .red
        }
    }

}

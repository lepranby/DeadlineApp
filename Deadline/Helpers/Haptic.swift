//  Haptic.swift
//  Deadline
//
//  Created by Aleksej Shapran on 18.05.24

import SwiftUI

func haptic () {
    let hapticAction = UIImpactFeedbackGenerator(style: .medium)
    hapticAction.impactOccurred()
}

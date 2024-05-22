//
//  HomeView.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24.
//

import SwiftUI

struct HomeView: View {

    @AppStorage("AppearanceTitle") private var appearanceTitle: Bool = true

    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Active")
                .navigationBarTitleDisplayMode(appearanceTitle ? .inline : .large)
        }
    }
}

#Preview {
    HomeView()
}

//  SettingsView.swift
//  Deadline
//
//  Created by Aleksej Shapran on 08.04.24

import SwiftUI

struct SettingsView: View {

    @AppStorage("Username") private var username: String = ""
    @AppStorage("AppearanceTitle") private var appearanceTitle: Bool = true

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        Section {
                            HStack (spacing: 6) {
                                Image(systemName: "person.crop.circle")
                                TextField("Username", text: $username)
                                    .scrollDismissesKeyboard(.immediately)
                            }
                        } header: {
                            Text("Profile")
                        } footer: {
                            Text("Will appear on the main page")
                        }
                        Section ("Appearance") {
                            AnimatedToggle(isOn: $appearanceTitle, text: "Display smart titles")
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .background(.backgroundForm)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(appearanceTitle ? .inline : .large)
        }
    }
}


#Preview {
    SettingsView()
}

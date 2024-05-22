//  IntroScreen.swift
//  Deadline
//
//  Created by Aleksej Shapran on 18.05.24

import SwiftUI

struct IntroScreen: View {

    @AppStorage("isFirstTime") private var isFirstTime: Bool = true

    var body: some View {
        VStack (spacing: 14) {
            Text("What's new in\nDeadline?").font(.largeTitle).bold()
                .multilineTextAlignment(.leading)
                .padding(.top, 65)
                .padding(.bottom, 35)

            VStack(alignment: .leading, spacing: 26, content: {
                PointView(symbol: "circle.circle", title: "Tasks", subTitle: "Create tasks and set priority")
                PointView(symbol: "checkmark.gobackward", title: "Completed notes", subTitle: "All your completed tasks are displayed on a separate screen. They can be restored or deleted completely")
                PointView(symbol: "lock.circle", title: "Confidentiality", subTitle: "Your data is protected using biometrics")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            Spacer(minLength: 10)
            Button(action: {
                isFirstTime = false
                haptic()
            }, label: {
                Text("Got It")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(appTint.gradient, in: .rect(cornerRadius: 14))
                    .contentShape(.rect)
            }).padding(.horizontal)
        }
        .padding(16)
    }

    @ViewBuilder func PointView(symbol: String, title: String, subTitle: String) -> some View {
        HStack (spacing: 20) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 46)
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .foregroundStyle(.secondary)
            })
        }
    }
}

#Preview {
    IntroScreen()
}

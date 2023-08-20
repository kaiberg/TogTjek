//
//  VersionInfo.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import SwiftUI

struct VersionInfo: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    var body: some View {
        VStack(alignment: .leading) {
                Text("Version: \(appVersion ?? "UNKNOWN")")
                Text("Build: \(appBuild ?? "UNKNOWN")")
            }
            .frame(width: 100)
            .foregroundStyle(.secondary)
            .font(.footnote)
        }
}

#Preview {
    VersionInfo()
}

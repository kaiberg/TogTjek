//
//  Settings.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import SwiftUI

struct Settings: View {
    @State var language: String = "Danish"
    
    var body: some View {
        VStack {
            Section {
                NavigationStack {
                    List {
                        Section {
                            LanguageOptions()
                        }
                    }

                }
            }
            
            Spacer()
            VersionInfo()
        }

    }
}

#Preview {
    Settings()
}

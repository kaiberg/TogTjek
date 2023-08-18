//
//  LanguageOptions.swift
//  TogTjek
//
//  Created by kai delay on 16/08/2023.
//

import SwiftUI

struct LanguageOptions: View {
    var currentLanguage: LocalizedStringKey = "SELECTED_LANGUAGE"
    
    var body: some View {
            HStack {
                Text("Language")
                Spacer()
                Text(currentLanguage)
                    .foregroundStyle(.secondary)
            }.onTapGesture {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    
                    UIApplication.shared.open(settingsUrl)
                }
            }
        }
    }

//
//#Preview {
//    @State var s = "Danish"
//    LanguageOptions(language: $s)
//}

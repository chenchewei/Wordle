//
//  SettingsView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/30.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var colorScheme: ColorSchemeManager
    @EnvironmentObject var dataModel: WordleDataModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle("Hard Mode", isOn: dataModel.$isHardMode)
                Text("Change Scheme")
                Picker("Display Mode", selection: $colorScheme.colorScheme) {
                    Text("Dark")
                        .tag(ColorScheme.dark)
                    Text("Light")
                        .tag(ColorScheme.light)
                    Text("System")
                        .tag(ColorScheme.unspecified)
                }
                .pickerStyle(.segmented)
                Spacer()
            }
            .padding()
            .navigationTitle("Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ColorSchemeManager())
        .environmentObject(WordleDataModel())
}

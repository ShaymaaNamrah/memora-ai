import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section("Account") {
                    Text("Guest user")
                    Text("Memora AI Free Plan")
                }

                Section("Preferences") {
                    Toggle("Dark mode", isOn: .constant(false))
                    Toggle("Daily reminders", isOn: .constant(true))
                }

                Section("App") {
                    Text("Language: English / German")
                    Text("Version 1.0")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
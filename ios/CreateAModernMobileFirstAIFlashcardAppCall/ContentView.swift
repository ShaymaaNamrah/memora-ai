import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var selection: Tab = .home

    enum Tab: Hashable {
        case home, study, analytics, settings
    }

    var body: some View {
        Group {
            TabView(selection: $selection) {
                DashboardView()
                    .tabItem { Label("Decks", systemImage: "rectangle.stack.fill") }
                    .tag(Tab.home)
            
                GenerateView()
                    .tabItem { Label("Study", systemImage: "bolt.fill") }
                    .tag(Tab.study)
            
                DashboardView()
                    .tabItem { Label("Progress", systemImage: "chart.bar.fill") }
                    .tag(Tab.analytics)
            
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape.fill") }
                    .tag(Tab.settings)
            }
            .tint(Theme.Palette.accent)
            .onAppear { SampleData.seedIfNeeded(context) }
        }
        .trackView("ContentView")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Deck.self, Flashcard.self], inMemory: true)
}

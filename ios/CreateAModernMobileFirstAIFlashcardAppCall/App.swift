import SwiftUI
import SwiftData

@main
struct SmartCardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Deck.self, Flashcard.self])
    }
}

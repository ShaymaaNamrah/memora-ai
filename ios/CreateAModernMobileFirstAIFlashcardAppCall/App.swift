import SwiftUI
import SwiftData

@main
struct Memora AI: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Deck.self, Flashcard.self])
    }
}

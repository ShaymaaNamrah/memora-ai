import SwiftUI
import SwiftData

@main
struct MemoraAI: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Deck.self, Flashcard.self])
    }
}

import Foundation
import SwiftData

/// Seeds the store with realistic study decks the first time the app launches.
enum SampleData {

    static func seedIfNeeded(_ context: ModelContext) {
        let existing = try? context.fetch(FetchDescriptor<Deck>())
        guard (existing?.isEmpty ?? true) else { return }
        for deck in makeDecks() {
            context.insert(deck)
        }
        try? context.save()
    }

    static func makeDecks() -> [Deck] {
        let cal = Calendar.current
        let now = Date()
        func daysAgo(_ d: Int) -> Date { cal.date(byAdding: .day, value: -d, to: now) ?? now }
        func dueIn(_ d: Int) -> Date { cal.date(byAdding: .day, value: d, to: now) ?? now }

        let neuro = Deck(
            title: "Neuroanatomy — Cranial Nerves",
            subject: "Medicine",
            emoji: "🧠",
            createdAt: daysAgo(9),
            cards: [
                Flashcard(kind: .qa, prompt: "Which cranial nerve controls the muscles of facial expression?",
                          answer: "The facial nerve (CN VII).",
                          reviewCount: 3, dueDate: dueIn(0), lastRating: .medium),
                Flashcard(kind: .qa, prompt: "What is the only cranial nerve that exits the posterior brainstem?",
                          answer: "The trochlear nerve (CN IV).",
                          reviewCount: 2, dueDate: dueIn(0), lastRating: .hard),
                Flashcard(kind: .multipleChoice,
                          prompt: "Which cranial nerve is responsible for hearing and balance?",
                          answer: "Vestibulocochlear (CN VIII)",
                          options: ["Vestibulocochlear (CN VIII)", "Vagus (CN X)", "Trigeminal (CN V)", "Abducens (CN VI)"],
                          reviewCount: 1, dueDate: dueIn(2), lastRating: .easy),
                Flashcard(kind: .trueFalse,
                          prompt: "The optic nerve (CN II) is responsible for the sense of smell.",
                          answer: "False — the olfactory nerve (CN I) handles smell; CN II carries vision.",
                          options: ["True", "False"],
                          reviewCount: 4, dueDate: dueIn(5), lastRating: .easy),
            ]
        )

        let kanji = Deck(
            title: "JLPT N3 — Core Kanji",
            subject: "Japanese",
            emoji: "🇯🇵",
            createdAt: daysAgo(4),
            cards: [
                Flashcard(kind: .qa, prompt: "What does economy / 経済 (けいざい) translate to?",
                          answer: "Economy / economics.",
                          reviewCount: 1, dueDate: dueIn(0), lastRating: .medium),
                Flashcard(kind: .qa, prompt: "Reading and meaning of 政府?",
                          answer: "せいふ (seifu) — government.",
                          reviewCount: 0, dueDate: dueIn(0)),
                Flashcard(kind: .multipleChoice, prompt: "Which word means 'environment'?",
                          answer: "環境 (かんきょう)",
                          options: ["環境 (かんきょう)", "関係 (かんけい)", "感想 (かんそう)", "観光 (かんこう)"],
                          reviewCount: 2, dueDate: dueIn(1), lastRating: .easy),
            ]
        )

        let macro = Deck(
            title: "Macroeconomics — Fiscal Policy",
            subject: "Economics",
            emoji: "📈",
            createdAt: daysAgo(2),
            cards: [
                Flashcard(kind: .qa, prompt: "Define crowding out.",
                          answer: "When increased government borrowing raises interest rates and reduces private investment.",
                          reviewCount: 0, dueDate: dueIn(0)),
                Flashcard(kind: .trueFalse,
                          prompt: "Expansionary fiscal policy aims to reduce aggregate demand.",
                          answer: "False — expansionary fiscal policy increases aggregate demand.",
                          options: ["True", "False"],
                          reviewCount: 1, dueDate: dueIn(0), lastRating: .hard),
                Flashcard(kind: .multipleChoice, prompt: "Which is an automatic stabilizer?",
                          answer: "Unemployment benefits",
                          options: ["Unemployment benefits", "A new highway bill", "A one-time tax rebate", "Quantitative easing"],
                          reviewCount: 2, dueDate: dueIn(3), lastRating: .medium),
            ]
        )

        let algo = Deck(
            title: "Algorithms — Big-O & Sorting",
            subject: "Computer Science",
            emoji: "💻",
            createdAt: daysAgo(1),
            cards: [
                Flashcard(kind: .qa, prompt: "What is the average-case time complexity of quicksort?",
                          answer: "O(n log n).",
                          reviewCount: 3, dueDate: dueIn(4), lastRating: .easy),
                Flashcard(kind: .multipleChoice, prompt: "Which sort is stable and runs in O(n log n) worst case?",
                          answer: "Merge sort",
                          options: ["Merge sort", "Quicksort", "Heapsort", "Selection sort"],
                          reviewCount: 1, dueDate: dueIn(0), lastRating: .medium),
            ]
        )

        return [neuro, kanji, macro, algo]
    }
}

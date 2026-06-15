import Foundation
import SwiftData

/// The kind of card the AI generated / the user is studying.
enum CardKind: String, Codable, CaseIterable, Identifiable {
    case qa
    case multipleChoice
    case trueFalse

    var id: String { rawValue }

    var title: String {
        switch self {
        case .qa: return "Q&A"
        case .multipleChoice: return "Multiple choice"
        case .trueFalse: return "True / false"
        }
    }

    var symbol: String {
        switch self {
        case .qa: return "text.bubble"
        case .multipleChoice: return "list.bullet"
        case .trueFalse: return "checkmark.circle"
        }
    }
}

/// FSRS-inspired difficulty rating the user gives after seeing a card.
enum Difficulty: String, Codable, CaseIterable, Identifiable {
    case hard
    case medium
    case easy

    var id: String { rawValue }

    var title: String {
        switch self {
        case .hard: return "Hard"
        case .medium: return "Medium"
        case .easy: return "Easy"
        }
    }

    /// Days until the card is due again (very small mock of FSRS intervals).
    var intervalDays: Int {
        switch self {
        case .hard: return 1
        case .medium: return 3
        case .easy: return 7
        }
    }
}

@Model
final class Deck {
    @Attribute(.unique) var id: UUID
    var title: String
    var subject: String
    var emoji: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Flashcard.deck)
    var cards: [Flashcard]

    init(
        id: UUID = UUID(),
        title: String,
        subject: String,
        emoji: String = "📘",
        createdAt: Date = .now,
        cards: [Flashcard] = []
    ) {
        self.id = id
        self.title = title
        self.subject = subject
        self.emoji = emoji
        self.createdAt = createdAt
        self.cards = cards
    }

    // MARK: Derived study state
    var totalCount: Int { cards.count }

    var masteredCount: Int { cards.filter { $0.lastRating == .easy && $0.reviewCount > 0 }.count }

    var dueCount: Int { cards.filter { $0.isDue }.count }

    /// 0...1 mastery used for progress rings.
    var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(masteredCount) / Double(totalCount)
    }
}

@Model
final class Flashcard {
    @Attribute(.unique) var id: UUID
    var kindRaw: String
    var prompt: String
    var answer: String
    /// For multiple-choice cards; empty otherwise. First entry is treated as correct.
    var options: [String]
    var createdAt: Date

    // Spaced-repetition state
    var reviewCount: Int
    var dueDate: Date
    var lastRatingRaw: String?

    var deck: Deck?

    init(
        id: UUID = UUID(),
        kind: CardKind,
        prompt: String,
        answer: String,
        options: [String] = [],
        createdAt: Date = .now,
        reviewCount: Int = 0,
        dueDate: Date = .now,
        lastRating: Difficulty? = nil
    ) {
        self.id = id
        self.kindRaw = kind.rawValue
        self.prompt = prompt
        self.answer = answer
        self.options = options
        self.createdAt = createdAt
        self.reviewCount = reviewCount
        self.dueDate = dueDate
        self.lastRatingRaw = lastRating?.rawValue
    }

    var kind: CardKind {
        get { CardKind(rawValue: kindRaw) ?? .qa }
        set { kindRaw = newValue.rawValue }
    }

    var lastRating: Difficulty? {
        get { lastRatingRaw.flatMap(Difficulty.init) }
        set { lastRatingRaw = newValue?.rawValue }
    }

    var isDue: Bool { dueDate <= Date() }

    /// Apply a rating: bump review count and reschedule with a mock FSRS interval.
    func apply(_ rating: Difficulty, now: Date = .now) {
        reviewCount += 1
        lastRating = rating
        dueDate = Calendar.current.date(byAdding: .day, value: rating.intervalDays, to: now) ?? now
    }
}

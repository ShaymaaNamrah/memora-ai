import SwiftUI
import SwiftData

struct DeckDetailView: View {
    @Bindable var deck: Deck
    @Environment(\.colorScheme) private var scheme
    @State private var showStudy = false
    @State private var showQuiz = false

    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Space.lg) {
                    header
            
                    HStack(spacing: Theme.Space.sm) {
                        actionButton(title: "Study", symbol: "rectangle.portrait.on.rectangle.portrait.angled.fill", filled: true) {
                            showStudy = true
                        }
                        actionButton(title: "Quiz", symbol: "timer", filled: false) {
                            showQuiz = true
                        }
                    }
            
                    Text("Cards")
                        .font(.system(.headline, design: .rounded))
                        .foregroundStyle(Theme.ink(scheme))
            
                    VStack(spacing: Theme.Space.sm) {
                        ForEach(deck.cards) { card in
                            cardRow(card)
                        }
                    }
                }
                .padding(Theme.Space.md)
            }
            .background(Theme.canvas(scheme))
            .navigationTitle(deck.title)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showStudy) {
                GenerateView(deck: deck)
            }
            .fullScreenCover(isPresented: $showQuiz) {
                QuizView(deck: deck)
            }
        }
        .trackView("DeckDetailView")
    }

    private var header: some View {
        HStack(spacing: Theme.Space.md) {
            Text(deck.emoji)
                .font(.system(size: 40))
                .frame(width: 68, height: 68)
                .background(Theme.Palette.accentSoft, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            VStack(alignment: .leading, spacing: 6) {
                Text(deck.subject)
                    .font(.subheadline)
                    .foregroundStyle(Theme.subtleInk(scheme))
                Text("\(deck.totalCount) cards · \(deck.dueCount) due")
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(Theme.ink(scheme))
            }
            Spacer()
            ProgressRing(progress: deck.progress, size: 58, label: "\(Int(deck.progress * 100))")
        }
        .smartCard(scheme)
    }

    private func actionButton(title: String, symbol: String, filled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(title, systemImage: symbol)
                .font(.system(.body, design: .rounded).weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                        .fill(filled ? Theme.Palette.accent : Theme.Palette.accentSoft)
                )
                .foregroundStyle(filled ? .white : Theme.Palette.accent)
        }
        .disabled(deck.cards.isEmpty)
    }

    private func cardRow(_ card: Flashcard) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Label(card.kind.title, systemImage: card.kind.symbol)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Theme.subtleInk(scheme))
                Spacer()
                if card.isDue {
                    Text("Due")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(Theme.Palette.accent)
                }
            }
            Text(card.prompt)
                .font(.system(.subheadline, design: .rounded).weight(.medium))
                .foregroundStyle(Theme.ink(scheme))
            Text(card.answer)
                .font(.subheadline)
                .foregroundStyle(Theme.subtleInk(scheme))
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .smartCard(scheme)
    }
}

#Preview {
    NavigationStack {
        DeckDetailView(deck: SampleData.makeDecks()[0])
    }
    .modelContainer(for: [Deck.self, Flashcard.self], inMemory: true)
}

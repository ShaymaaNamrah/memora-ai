import SwiftUI

/// A single deck row/card on the dashboard.
struct DeckCard: View {
    let deck: Deck
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(spacing: Theme.Space.md) {
            Text(deck.emoji)
                .font(.system(size: 30))
                .frame(width: 52, height: 52)
                .background(Theme.Palette.accentSoft, in: RoundedRectangle(cornerRadius: 14, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(deck.title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(Theme.ink(scheme))
                    .lineLimit(2)

                HStack(spacing: 8) {
                    Text(deck.subject)
                    Text("·")
                    Text("\(deck.totalCount) cards")
                }
                .font(.subheadline)
                .foregroundStyle(Theme.subtleInk(scheme))

                if deck.dueCount > 0 {
                    Text("\(deck.dueCount) due today")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Theme.Palette.accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Theme.Palette.accentSoft, in: Capsule())
                        .padding(.top, 2)
                }
            }

            Spacer(minLength: 0)

            ProgressRing(progress: deck.progress, size: 46,
                         label: "\(Int(deck.progress * 100))")
        }
        .smartCard(scheme)
    }
}

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.colorScheme) private var scheme
    @Query(sort: \Deck.createdAt, order: .reverse) private var decks: [Deck]
    @State private var search = ""
    @State private var showGenerate = false

    private var filteredDecks: [Deck] {
        guard !search.isEmpty else { return decks }
        return decks.filter {
            $0.title.localizedCaseInsensitiveContains(search)
            || $0.subject.localizedCaseInsensitiveContains(search)
        }
    }

    private var totalDue: Int { decks.reduce(0) { $0 + $1.dueCount } }
    private var totalCards: Int { decks.reduce(0) { $0 + $1.totalCount } }
    private var totalMastered: Int { decks.reduce(0) { $0 + $1.masteredCount } }

    var body: some View {
        Group {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Space.lg) {
                        streakHeader
                        statStrip
            
                        if !filteredDecks.isEmpty {
                            sectionTitle("Your decks")
                            VStack(spacing: Theme.Space.sm) {
                                ForEach(filteredDecks) { deck in
                                    NavigationLink(value: deck) {
                                        DeckCard(deck: deck)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        } else {
                            emptyState
                        }
                    }
                    .padding(Theme.Space.md)
                }
                .background(Theme.canvas(scheme))
                .navigationTitle("SmartCards")
                .searchable(text: $search, prompt: "Search decks")
                .navigationDestination(for: Deck.self) { DeckDetailView(deck: $0) }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showGenerate = true
                        } label: {
                            Image(systemName: "sparkles")
                        }
                        .accessibilityLabel("Generate with AI")
                    }
                }
                .sheet(isPresented: $showGenerate) {
                    GenerateView()
                }
            }
        }
        .trackView("DashboardView")
    }

    // MARK: Streak header
    private var streakHeader: some View {
        HStack(spacing: Theme.Space.md) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Welcome back")
                    .font(.subheadline)
                    .foregroundStyle(Theme.subtleInk(scheme))
                Text(totalDue > 0 ? "\(totalDue) cards due today" : "You're all caught up 🎉")
                    .font(.system(.title2, design: .rounded).weight(.bold))
                    .foregroundStyle(Theme.ink(scheme))
            }
            Spacer()
            HStack(spacing: 6) {
                Image(systemName: "flame.fill")
                Text("12")
                    .font(.system(.title3, design: .rounded).weight(.bold))
            }
            .foregroundStyle(Theme.Palette.accent)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Theme.Palette.accentSoft, in: Capsule())
        }
    }

    private var statStrip: some View {
        HStack(spacing: Theme.Space.sm) {
            StatTile(value: "\(decks.count)", caption: "Decks", symbol: "rectangle.stack.fill")
            StatTile(value: "\(totalMastered)", caption: "Mastered", symbol: "checkmark.seal.fill", tint: Theme.Palette.easy)
            StatTile(value: "\(totalCards)", caption: "Total cards", symbol: "square.grid.2x2.fill")
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(.headline, design: .rounded))
            .foregroundStyle(Theme.ink(scheme))
    }

    private var emptyState: some View {
        VStack(spacing: Theme.Space.md) {
            Image(systemName: "sparkles.rectangle.stack")
                .font(.system(size: 44))
                .foregroundStyle(Theme.Palette.accent)
            Text(search.isEmpty ? "No decks yet" : "No decks match “\(search)”")
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(Theme.ink(scheme))
            if search.isEmpty {
                Text("Paste your notes or import a PDF and let AI build your first deck.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Theme.subtleInk(scheme))
                Button {
                    showGenerate = true
                } label: {
                    Label("Generate flashcards", systemImage: "sparkles")
                        .font(.system(.body, design: .rounded).weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Theme.Palette.accent, in: RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous))
                        .foregroundStyle(.white)
                }
                .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Theme.Space.xl)
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: [Deck.self, Flashcard.self], inMemory: true)
}

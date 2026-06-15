import SwiftUI
import SwiftData

/// AI Generate flow — source input, card-type picker, mock processing, editable review.
/// Full implementation lands in the Generate milestone; this is the entry scaffold.
struct GenerateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    @State private var sourceText = ""
    @State private var selectedKinds: Set<CardKind> = [.qa]

    var body: some View {
        Group {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Space.lg) {
                        intro
            
                        Text("Paste your notes")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(Theme.ink(scheme))
            
                        TextEditor(text: $sourceText)
                            .frame(minHeight: 180)
                            .scrollContentBackground(.hidden)
                            .padding(8)
                            .background(Theme.surface(scheme), in: RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                                    .stroke(Theme.hairline(scheme), lineWidth: 1)
                            )
                            .overlay(alignment: .topLeading) {
                                if sourceText.isEmpty {
                                    Text("e.g. The mitochondria is the powerhouse of the cell…")
                                        .font(.subheadline)
                                        .foregroundStyle(Theme.subtleInk(scheme))
                                        .padding(16)
                                        .allowsHitTesting(false)
                                }
                            }
            
                        Label("Import PDF or DOCX coming in the next pass", systemImage: "doc.badge.plus")
                            .font(.footnote)
                            .foregroundStyle(Theme.subtleInk(scheme))
            
                        Text("Card types")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(Theme.ink(scheme))
                        kindPicker
                    }
                    .padding(Theme.Space.md)
                }
                .background(Theme.canvas(scheme))
                .navigationTitle("Generate")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") { dismiss() }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Generate") {}
                            .fontWeight(.semibold)
                            .disabled(sourceText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedKinds.isEmpty)
                    }
                }
            }
        }
        .trackView("GenerateView")
    }

    private var intro: some View {
        HStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.title2)
                .foregroundStyle(Theme.Palette.accent)
            Text("Drop in your study material and AI turns it into a ready-to-study deck.")
                .font(.subheadline)
                .foregroundStyle(Theme.ink(scheme))
        }
        .smartCard(scheme)
    }

    private var kindPicker: some View {
        VStack(spacing: Theme.Space.sm) {
            ForEach(CardKind.allCases) { kind in
                Button {
                    if selectedKinds.contains(kind) { selectedKinds.remove(kind) }
                    else { selectedKinds.insert(kind) }
                } label: {
                    HStack {
                        Label(kind.title, systemImage: kind.symbol)
                            .font(.system(.body, design: .rounded).weight(.medium))
                            .foregroundStyle(Theme.ink(scheme))
                        Spacer()
                        Image(systemName: selectedKinds.contains(kind) ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(selectedKinds.contains(kind) ? Theme.Palette.accent : Theme.subtleInk(scheme))
                    }
                    .smartCard(scheme)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    GenerateView()
        .modelContainer(for: [Deck.self, Flashcard.self], inMemory: true)
}

import SwiftUI

/// Compact metric tile used in the dashboard header strip.
struct StatTile: View {
    let value: String
    let caption: String
    let symbol: String
    var tint: Color = Theme.Palette.accent
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: symbol)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(tint)
            Text(value)
                .font(.system(.title2, design: .rounded).weight(.bold))
                .foregroundStyle(Theme.ink(scheme))
            Text(caption)
                .font(.caption)
                .foregroundStyle(Theme.subtleInk(scheme))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .smartCard(scheme, padding: Theme.Space.md)
    }
}

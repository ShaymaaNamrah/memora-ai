import SwiftUI

/// SmartCards design system — Premium Ink + Indigo.
/// One accent hue only; everything else neutral. Light + dark aware.
enum Theme {

    // MARK: Palette
    enum Palette {
        /// #6366F1 — reserved for streaks, AI moments, primary CTAs.
        static let accent = Color(hex: 0x6366F1)
        static let accentSoft = Color(hex: 0x6366F1).opacity(0.12)

        // Semantic difficulty states (derived neutrals + accent family).
        static let easy = Color(hex: 0x16A34A)
        static let medium = Color(hex: 0xD97706)
        static let hard = Color(hex: 0xDC2626)
    }

    // MARK: Adaptive fallbacks (used when asset colors are absent)
    static func canvas(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: 0x101012) : Color(hex: 0xFAFAF7)
    }

    static func surface(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: 0x1B1B1F) : Color(hex: 0xFFFFFF)
    }

    static func ink(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: 0xF4F4F5) : Color(hex: 0x18181B)
    }

    static func subtleInk(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: 0xA1A1AA) : Color(hex: 0x71717A)
    }

    static func hairline(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.06)
    }

    // MARK: Radii & spacing
    enum Radius {
        static let card: CGFloat = 18
        static let control: CGFloat = 12
        static let pill: CGFloat = 999
    }

    enum Space {
        static let xs: CGFloat = 6
        static let sm: CGFloat = 10
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 36
    }
}

// MARK: - Color hex helper
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

// MARK: - Reusable surface styling
extension View {
    /// Standard SmartCards surface card: soft surface fill, barely-there shadow, hairline border.
    func smartCard(_ scheme: ColorScheme, padding: CGFloat = Theme.Space.md, radius: CGFloat = Theme.Radius.card) -> some View {
        self
            .padding(padding)
            .background(Theme.surface(scheme), in: RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(Theme.hairline(scheme), lineWidth: 1)
            )
            .shadow(color: .black.opacity(scheme == .dark ? 0.30 : 0.04), radius: 6, y: 3)
    }
}

import SwiftUI

/// Thin circular progress ring used on deck cards and headers.
struct ProgressRing: View {
    var progress: Double
    var size: CGFloat = 44
    var lineWidth: CGFloat = 5
    var tint: Color = Theme.Palette.accent
    var label: String?

    @Environment(\.colorScheme) private var scheme

    var body: some View {
        ZStack {
            Circle()
                .stroke(Theme.hairline(scheme), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: max(0.001, min(1, progress)))
                .stroke(tint, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.smooth, value: progress)
            if let label {
                Text(label)
                    .font(.system(size: size * 0.3, weight: .bold, design: .rounded))
                    .foregroundStyle(Theme.ink(scheme))
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    HStack(spacing: 20) {
        ProgressRing(progress: 0.35, label: "35%")
        ProgressRing(progress: 0.8, size: 60, label: "80%")
    }
    .padding()
}

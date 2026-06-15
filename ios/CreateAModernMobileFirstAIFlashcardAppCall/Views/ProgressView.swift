import SwiftUI

struct ProgressView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Progress")
                    .font(.largeTitle.bold())

                Text("Track your learning progress here.")
                    .foregroundStyle(.secondary)

                HStack {
                    StatCard(title: "Cards learned", value: "24")
                    StatCard(title: "Accuracy", value: "82%")
                }

                HStack {
                    StatCard(title: "Streak", value: "5 days")
                    StatCard(title: "Due today", value: "7")
                }

                Spacer()
            }
            .padding()
        }
    }
}
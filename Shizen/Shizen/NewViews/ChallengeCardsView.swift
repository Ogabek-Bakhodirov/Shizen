import SwiftUI

struct ChallengeCardsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ChallengeCardView(
                    emoji: "🏃‍♂️",
                    title: "Daily 5k Run Challenge",
                    description: "Join a global community and commit to running 5 kilometers every day for 30 days.",
                    isFree: true,
                    price: nil,
                    participants: "1,200 Participants"
                )
                
                ChallengeCardView(
                    emoji: "🧘‍♀️",
                    title: "Mindful Morning Meditation",
                    description: "Start your day with guided meditation sessions for 21 days. Enhance focus and mindfulness in your daily routine.",
                    isFree: false,
                    price: "UZS 25,000",
                    participants: "450 Participants"
                )
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .background(Color(.systemBackground))
    }
}

struct ChallengeCardView: View {
    let emoji: String
    let title: String
    let description: String
    let isFree: Bool
    let price: String?
    let participants: String
    
    // Define consistent left margin for alignment
    private let leftMargin: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section with emoji and title
            HStack(alignment: .top, spacing: 16) {
                // Emoji - positioned at leftMargin
                Text(emoji)
                    .font(.system(size: 32))
                    .frame(width: 50, height: 50, alignment: .center)
                
                // Title and description
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, leftMargin)
            
            // Bottom section with price badge and participants
            HStack {
                // Price badge - aligned with emoji position
                HStack {
                    Text(isFree ? "Free" : "Paid - \(price ?? "")")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isFree ? Color.green : Color.orange)
                        )
                    
                    Spacer()
                }
                .padding(.leading, leftMargin) // Same position as emoji
                
                // Participants count - right aligned
                Text(participants)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.trailing, leftMargin)
            }
            .padding(.top, 16)
            .padding(.bottom, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

// Preview
struct ChallengeCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCardsView()
            .previewLayout(.sizeThatFits)
            .background(Color(.systemGray6))
    }
}
import SwiftUI

struct AwardDescriptionView: View {
    // Award Struct (this can be replaced with actual data)
    let award: AwardManagerEnum
    
    // To handle the back button functionality
    @Environment(\.presentationMode) var presentationMode
    
    @State private var stars: [Star] = (0..<15).map { _ in Star.random() } // Initial stars
    
    var body: some View {
        ZStack {
            // Background: Blinking stars
            Color.black.edgesIgnoringSafeArea(.all) // Dark background

            ForEach(stars) { star in
                Text("⭐")
                    .font(.system(size: star.size))
                    .opacity(star.isVisible ? 1 : 0) // Blink effect
                    .position(star.position)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: star.isVisible)
            }

            // Foreground: Award details
            VStack {
                // Top bar with back button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }) {
                        HStack {
                            Image(.backArrowWhiteIcon)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            Text("Orqaga")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .regular))
                        }
                    }
                    .padding()

                    Spacer()
                }
                
                Spacer()
                
                // Award Logo
                Text("🏆")
                    .font(.system(size: 130))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Award Title
                Text(award.award.awardTitle)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                // Award Description
                Text(award.award.awardDescription)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                Spacer()
            }
        }
        .onAppear {
            startAnimation()
        }
    }

    // Function to continuously update star positions & visibility
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation {
                stars = (0..<15).map { _ in Star.random() }
            }
        }
    }
}

// MARK: - Star Model
struct Star: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var isVisible: Bool

    static func random() -> Star {
        Star(
            position: CGPoint(x: CGFloat.random(in: 20...350), y: CGFloat.random(in: 50...700)),
            size: CGFloat.random(in: 15...30),
            isVisible: Bool.random()
        )
    }
}

//struct AwardDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AwardDescriptionView(award: UserAwardsListStruct(icon: "🏆", title: "Quiz Conqueror", description: "This award is for quiz champions!"))
//    }
//}

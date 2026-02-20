import SwiftUI

struct RootView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    var body: some View {
        if hasSeenOnboarding {
                    HomeView()
                        .transition(.move(edge: .trailing))
                } else {
                    OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                }
    }
}

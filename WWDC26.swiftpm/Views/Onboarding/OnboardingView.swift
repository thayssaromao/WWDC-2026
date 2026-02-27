import SwiftUI

enum OnboardingStep: Hashable {
    case arrival
    case feeling
    case tools
}

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentStep: OnboardingStep = .arrival
    
    var body: some View {
        ZStack {
            Image("backgroundGREEN")
                .resizable()
                .ignoresSafeArea()
            
            Group {
                switch currentStep {
                case .arrival:
                    OnboardingScene1(action: {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            currentStep = .feeling
                        }
                    })
                case .feeling:
                    OnboardingScene2(action: {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            currentStep = .tools
                        }
                    })
                case .tools:
                    OnboardingScene3(finishAction: {
                        withAnimation{
                            hasSeenOnboarding = true
                        }
                    })
                }
            }
            .transition(.asymmetric(insertion:.opacity.combined(with: .move(edge: .trailing)), removal: .opacity.combined(with:.move(edge: .top))))
        }
    }
}

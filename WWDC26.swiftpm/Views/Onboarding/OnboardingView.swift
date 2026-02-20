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
            Color.cyan
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


struct OnboardingScene1: View {
    var action: () -> ()
    
    var body: some View {
        VStack(spacing: 20) {
                    Image("testeImg")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                    
                    Text("Oie! Acabei de chegar de uma grande viagem...")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
            
                    Text(" Às vezes, a gente chega em um lugar novo e as palavras ainda não fazem sentido.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: action) {
                        Text("Continuar")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding()
    }
}

struct OnboardingScene2: View {
    var action: () -> ()
    
    var body: some View {
        VStack(spacing: 20) {
                    Image("testeImg")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                    
                    Text("Pode parecer difícil mas agora você tem oportunidade de conhecer novas palavras e novas pessoas!")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: action) {
                        Text("Continuar")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding()
    }
}

struct OnboardingScene3: View {
    var finishAction: () -> ()
    @State private var hasInteracted: Bool = false

    var body: some View {
        VStack {
            Text("Esta mochila tem tudo o que precisamos")
                .font(.headline)
                .padding(.top)
            
            Spacer()
            
            ZStack {
                Image("testeBag")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                HStack(spacing: 30) {
                    MagicItem(icon: "heart.fill", color: .red, label: "Self-care")
                    MagicItem(icon: "star.fill", color: .yellow, label: "Needs")
                    MagicItem(icon: "hand.wave.fill", color: .green, label: "Social")
                }
                .offset(y: -200)
            }
            
            Spacer()
            
            Text(hasInteracted ? "Agora você está pronto!" : "Toque em um cristal para ativar sua magia.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            .animation(.easeInOut, value: hasInteracted)
                   
                        if hasInteracted {
                            Button(action: finishAction) {
                                Text("Começar Jornada")
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal)
                            .transition(.scale.combined(with: .opacity))
                        }
        }
    }
    @ViewBuilder
        func MagicItem(icon: String, color: Color, label: String) -> some View {
            Button(action: {
                // Tocar o som harmônico
                // AudioService.shared.playSystemSound(id: 1004) ou seu arquivo mp3
                
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    hasInteracted = true
                }
            }) {
                VStack {
                    Image(systemName: icon)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .frame(width: 70, height: 70)
                        .background(color)
                        .clipShape(Circle())
                        .shadow(color: color.opacity(0.6), radius: hasInteracted ? 20 : 0) // Brilha se interagiu
                        .scaleEffect(hasInteracted ? 1.2 : 1.0) // Cresce se interagiu
                    
                    if hasInteracted {
                        Text(label)
                            .font(.caption)
                            .bold()
                            .transition(.opacity)
                            .padding()
                    }
                }
            }
        }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .init(get: { false }, set: { _ in }))
}

import SwiftUI

struct OnboardingScene3: View {
    var finishAction: () -> ()
    @State private var hasInteracted: Bool = false
    @State private var isAnimating: Bool = false
    @State private var selectedItem: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            HStack(spacing: 80) {
                MagicItem(icon: "heart.fill", color: .BLUE, label: "SELF-CARE")
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1), value: isAnimating)
                
                MagicItem(icon: "star.fill", color: .PINK, label: "NEEDS")
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2), value: isAnimating)
                
                MagicItem(icon: "hand.wave.fill", color: .GREEN, label: "SOCIAL")
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.3), value: isAnimating)
            }
            .offset(y: isAnimating ? 0 : 300)
            .scaleEffect(isAnimating ? 1.0 : 0.2)
            .opacity(isAnimating ? 1.0 : 0.0)
            
            Spacer()

            Image("backpack")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
                .zIndex(1)
            
            Spacer()

            ZStack {
                VStack(alignment: .center, spacing: 10) {
                    let quotation = """
                    This backpack has everything we need! 
                    Click on a globe to learn something new!
                    """
                    
                    Text(quotation)
                        .font(.system(size: 35, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .padding(.horizontal, 30)
                .frame(width: 700, height: 290)
                .background(.white)
                .cornerRadius(50)
                .overlay(
                  RoundedRectangle(cornerRadius: 50)
                    .inset(by: -10)
                    .stroke(Color.BLUE, lineWidth: 20)
                )
                
                if hasInteracted {
                    Button(action: finishAction) {
                        Image(systemName: "arrow.forward")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 96.3461)
                            .padding(.vertical, 21.41024)
                            .frame(width: 160, height: 90, alignment: .center)
                            .background(Color(red: 1, green: 0.4, blue: 0.2))
                            .cornerRadius(28.54699)
                            .shadow(color: Color(red: 0.75, green: 0.3, blue: 0.15), radius: 2.6, x: 0, y: 14.2735)
                    }
                    .padding(.horizontal)
                    .transition(.scale.combined(with: .opacity))
                    .offset(x:250, y: 130)
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            isAnimating = true
        }
    }
    
    @ViewBuilder
    func MagicItem(icon: String, color: Color, label: String) -> some View {
        let isSelected = selectedItem == label
        
        Button(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                selectedItem = label
                hasInteracted = true
            }
        }) {
            VStack(spacing: 10) {
                VStack(alignment: .center) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        .foregroundColor(Color.white)
                }
                .padding(10)
                .frame(width: 100, height: 100, alignment: .center)
                .background(color)
                .cornerRadius(80)
                .shadow(color: color.opacity(0.6), radius: isSelected ? 20 : 0)
                .overlay(
                  RoundedRectangle(cornerRadius: 80)
                    .inset(by: -1)
                    .stroke(.white, lineWidth: 6)
                )
                
                Text(label)
                    .font(.system(size: 20, weight: .bold ,design: .rounded))
                    .foregroundStyle(Color.black)
                    .transition(.opacity)
                    .padding()
            }
            .scaleEffect(isSelected ? 1.3 : 1.0)
            
        }
    }
}

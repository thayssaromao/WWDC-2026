import SwiftUI

struct OnboardingScene1: View {
    var action: () -> ()
    
    var body: some View {
        
        VStack(spacing: 20) {
            Spacer()
            ZStack {
                
                VStack(alignment: .center, spacing: 10) {
                    let quotation = """
                    Hi!

                    I just got back from a long trip and I don't know anything around here!

                    Sometimes, when you arrive in a new place, the words don't make sense yet...
                    """

                    Text(quotation)
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .padding(.horizontal, 30)
                .frame(width: 400, height: 648)
                .background(.white)
                .cornerRadius(50)
                .overlay(
                  RoundedRectangle(cornerRadius: 50)
                    .inset(by: -10)
                    .stroke(Color.BLUE, lineWidth: 20)
                )
                .offset(x: 80)
                
                Image("pencilOn1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 648)
                    .offset(x: -220, y: 30)
            }
            
            Spacer()
                    
            Button(action: action) {
                Image(systemName: "arrow.forward")
                    .font(.system(size: 50, weight: .bold, design: .rounded)
                    )
                    .foregroundColor(.white)
                    .padding(.horizontal, 96.3461)
                    .padding(.vertical, 21.41024)
                    .frame(width: 160, height: 90, alignment: .center)
                    .background(Color(red: 1, green: 0.4, blue: 0.2))
                    .cornerRadius(28.54699)
                    .shadow(color: Color(red: 0.75, green: 0.3, blue: 0.15), radius: 2.6, x: 0, y: 14.2735)
            }
            .offset(x:250)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

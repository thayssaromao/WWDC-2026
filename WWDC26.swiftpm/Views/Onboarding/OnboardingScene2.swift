import SwiftUI
import SwiftUI

struct OnboardingScene2: View {
    var action: () -> ()
    
    @State private var isAnimating = false
    
    let floatingWords = [
        (text: "Lanche", x: 180.0, y: -300.0, angle: 15.0, color: Color.blue),
        (text: "Amigo", x: 260.0, y: -100.0, angle: -10.0, color: Color.pink),
        (text: "OIE", x: -100.0, y: -380.0, angle: -20.0, color: Color.green),
        (text: "Pega-pega", x: 280.0, y: 150.0, angle: 25.0, color: Color.orange),
        (text: "Recreio", x: 50.0, y: -250.0, angle: -5.0, color: Color.purple),
        (text: "Bem vindo", x: 200.0, y: 50.0, angle: -15.0, color: Color.red),
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                
                ForEach(0..<floatingWords.count, id: \.self) { index in
                    let word = floatingWords[index]
                    Text(word.text)
                        .font(.system(size: 52, weight: .bold, design: .rounded))
                        .foregroundColor(word.color.opacity(0.8))
                        .rotationEffect(.degrees(word.angle))
                        .offset(x: word.x, y: word.y + (isAnimating ? -15 : 15))
                        .opacity(isAnimating ? 1 : 0)
                        .animation(
                            .easeInOut(duration: Double.random(in: 2.0...3.5))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...1)),
                            value: isAnimating
                        )
                }
                
                Image("pencilOn2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 748)
                    .offset(x: -160, y: -100)
                
                VStack(alignment: .center, spacing: 10) {
                    let quotation = """
                    It may seem difficult, but now you have the opportunity to learn new words and meet new people!
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
                .offset(y:320)
                
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
                .padding(.horizontal)
                .offset(x:250, y:470)
            }
        }
        .padding()
        .onAppear {
            isAnimating = true
        }
    }
}

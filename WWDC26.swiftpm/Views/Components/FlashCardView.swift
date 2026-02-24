import SwiftUI

struct FlashCardView: View {
    let phrase: Phrase
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: phrase.imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
            
            Text(phrase.nativeText)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(width: 260, height: 260)
        .background(Color.pink.opacity(0.8))
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white, lineWidth: 8)
        )
    }
}

import SwiftUI

struct AudioPillView: View {
    let phrase: Phrase
    @State private var isSpeaking = false
    var onAudioPlayed: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            
            Button(action: {
                TextToSpeechManager.shared.speak(text: phrase.targetText, language: "pt-BR")
                
                onAudioPlayed()
                
                withAnimation { isSpeaking = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation { isSpeaking = false }
                }
            }) {
                Image(systemName: isSpeaking ? "speaker.wave.3" : "speaker.wave.2")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(isSpeaking ? 1.1 : 1.0)
                    .frame(width: 441, height: 96, alignment: .center)
            }
            Text("Listen to translate")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.gray)
                            .italic()
            
        }
        .padding(.horizontal, 96.3461)
        .padding(.vertical, 21.41024)
        .frame(width: 300, height: 96, alignment: .center)
        .background(Color(red: 0.05, green: 0.66, blue: 0.87))
        .cornerRadius(28.54699)
        .shadow(color: Color(red: 0.05, green: 0.49, blue: 0.64), radius: 2.6, x: 0, y: 14.2735)
    }
}

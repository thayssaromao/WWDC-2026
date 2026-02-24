import AVFoundation

class TextToSpeechManager {
    static let shared = TextToSpeechManager()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(text: String, language: String = "pt-BR") {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Erro ao configurar áudio: \(error)")
        }
        
        let utterance = AVSpeechUtterance(string: text)
        
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        
        utterance.rate = 0.45
        utterance.pitchMultiplier = 1.1
        synthesizer.speak(utterance)
    }
    
    func stop() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
}

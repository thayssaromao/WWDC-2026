import SwiftUI

final class PhraseViewModel: ObservableObject {
    let phrase: Phrase
    
    init(phrase: Phrase) {
        self.phrase = phrase
    }
    
    func playAudio() {
        print("Tentando tocar: \(phrase.audioFileName)")
        AudioService.shared.playAudio(named: phrase.audioFileName)
    }
}

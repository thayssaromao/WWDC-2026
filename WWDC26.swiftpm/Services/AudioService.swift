import AVFoundation

final class AudioService {
    static let shared = AudioService()
    
    private var player: AVAudioPlayer?
    
    func playAudio(named fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("Áudio não encontrado")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Erro ao tocar áudio")
        }
    }
}

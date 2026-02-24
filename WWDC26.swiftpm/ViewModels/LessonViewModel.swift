import SwiftUI
import Combine

final class LessonViewModel: ObservableObject {
    var lesson: Lesson
    @Published var stepFinished: Bool = false
    @Published var isInQuizMode: Bool = false
    @Published var currentIndex: Int = 0
    @Published var speechRecognizer = SpeechRecognizerManager()
    @Published var isLastStep: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
    init(lesson: Lesson) {
        self.lesson = lesson
        self.speechRecognizer.requestAuthorization()
        
        speechRecognizer.$transcript
            .debounce(for: .seconds(0.8), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.checkPronunciation(spokenText: text)
            }
            .store(in: &cancellables)
    }
    
    func startListening() {
        speechRecognizer.startRecording()
    }
        
    func stopListening() {
        speechRecognizer.stopRecording()
    }
    
    private func checkPronunciation(spokenText: String) {
        guard let targetText = currentPhrase?.targetText else { return }
        
        let cleanedSpoken = spokenText.lowercased().folding(options: .diacriticInsensitive, locale: .current)
        let cleanedTarget = targetText.lowercased().folding(options: .diacriticInsensitive, locale: .current)
        
        if cleanedSpoken.contains(cleanedTarget) || cleanedSpoken == cleanedTarget {
            self.stepFinished = true
            self.stopListening()
            if currentIndex == lesson.phrases.count - 1 {
                isLastStep = true
            }
        }
    }
    var currentPhrase: Phrase? {
        guard currentIndex < lesson.phrases.count else { return nil }
        return lesson.phrases[currentIndex]
    }
    
    func next() {
        stepFinished = false
    
        if currentIndex < lesson.phrases.count - 1 {
            currentIndex += 1
            speechRecognizer.transcript = ""
        } else if  !isInQuizMode {
            isInQuizMode = true
            currentIndex = 0
        } else {
            isLastStep = true
        }
    }
    
    func completeLesson() {
        lesson.isCompleted = true
 
    }
    
}

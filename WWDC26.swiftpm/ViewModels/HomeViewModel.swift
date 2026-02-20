import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var lessons: [ Lesson ] = [ ]
    
    @Published var selectedCategory: PhraseCategory = .social {
        didSet {resetSelection()}
    }
    
    @Published var selectedLessonId: UUID?
    
    var filteredLessons: [ Lesson ] {
        lessons.filter { $0.category == selectedCategory}
    }
    
    init() {
        self.lessons = LessonData.allLessons
        resetSelection()
    }
    
    func isUnlocked(lesson: Lesson) -> Bool {
        if lesson.order == 1 { return true }
        
        let previousLesson = filteredLessons.first(where: { $0.order == lesson.order - 1 })
        return previousLesson?.isCompleted ?? false
    }
    
    func nextLesson() {
        guard let id = selectedLessonId,
              let currentIndex = filteredLessons.firstIndex(where: { $0.id == id }),
              currentIndex < filteredLessons.count - 1 else { return }
        
        withAnimation { selectedLessonId = filteredLessons[currentIndex + 1].id }
    }
    
    func previousLesson() {
        guard let id = selectedLessonId,
              let currentIndex = filteredLessons.firstIndex(where: { $0.id == id }),
              currentIndex > 0 else { return }
        
        withAnimation { selectedLessonId = filteredLessons[currentIndex - 1].id }
    }
    
    private func resetSelection() {
        selectedLessonId = filteredLessons.first?.id
    }
    
//    func loadMockData() {
//        
//        let phrase1 = Phrase(
//            nativeText: "Hi",
//            targetText: "Olá",
//            audioFileName: "olaC",
//            imageName: "hand.wave",
//            category: .social
//        )
//        
//        let phrase2 = Phrase(
//            nativeText: "Water please",
//            targetText: "Água por favor",
//            audioFileName: "water_audio",
//            imageName: "drop",
//            category: .needs
//        )
//        
//        let phrase3 = Phrase(
//            nativeText: "Let's Play?",
//            targetText: "Vamos Brincar?",
//            audioFileName: "play",
//            imageName: "gamecontroller",
//            category: .social
//        )
//        
//        let lesson1 = Lesson(
//            title: "Greetings",
//            phrases: [ phrase1 ],
//            description: "Learn some basic greetings in Portuguese",
//            category: .social,
//            order: 1
//        )
//        
//        let lesson2 = Lesson(
//            title: "Needs",
//            phrases: [ phrase2 ],
//            description: "Learn some basic needs in Portuguese",
//            category: .needs,
//            order: 1
//        )
//        
//        let lesson3 = Lesson(
//            title: "Social",
//            phrases: [ phrase3 ],
//            description: "Learn some social words in Portuguese",
//            category: .social,
//            order: 2
//        )
//        
//        self.lessons = [ lesson1, lesson2, lesson3]
//    }
}

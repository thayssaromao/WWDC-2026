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
    
    func markLessonAsCompleted(id: UUID) {
        if let index = lessons.firstIndex(where: { $0.id == id }) {
            lessons[index].isCompleted = true
            objectWillChange.send()
        }
    }

}

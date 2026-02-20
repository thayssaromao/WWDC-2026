import SwiftUI

struct Lesson: Identifiable, Hashable {
    let id = UUID()
    
    let title: String
    let phrases: [ Phrase ]
    let description: String
    let category: PhraseCategory
    var isCompleted: Bool = false
    
    let order: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        lhs.id == rhs.id
    }
}

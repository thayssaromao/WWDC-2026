import Foundation

struct Phrase: Identifiable {
    let id = UUID()
    
    let nativeText: String
    let targetText: String
    let audioFileName: String
    let imageName: String
    
    let category: PhraseCategory
}


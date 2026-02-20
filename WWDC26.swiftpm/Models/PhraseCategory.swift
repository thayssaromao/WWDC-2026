import SwiftUI

enum PhraseCategory: String, CaseIterable, Identifiable {
    
    case social = "Social"
    case selfCare = "Me"
    case needs = "Needs"
    
    var id: String { rawValue }
}

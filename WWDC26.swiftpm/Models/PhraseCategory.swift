import SwiftUI

enum PhraseCategory: String, CaseIterable, Identifiable {
    case social = "Social"
    case selfCare = "Me"
    case needs = "Needs"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .selfCare:
            return "star.fill"
        case .social:
            return "figure.2.arms.open"
        case .needs:
            return "heart.fill"
        }
    }
}

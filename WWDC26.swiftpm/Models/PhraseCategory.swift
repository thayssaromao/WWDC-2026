import SwiftUI

extension Color {
    static let GREEN = Color(red: 0.5, green: 0.76, blue: 0.26)
    static let BLUE = Color(red: 0.05, green: 0.66, blue: 0.87)
    static let PINK = Color.pink
}

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
    
    var Background: String {
        switch self {
        case .selfCare:
            return "backgroundBLUE"
        case .social:
            return "backgroundGREEN"
        case .needs:
            return "backgroundPINK"
        }
    }
    
    var categoryColor: Color {
        switch self {
        case .social: return .GREEN
        case .selfCare: return .BLUE
        case .needs: return .PINK
        }
    }
        
    var categoryColorLocked: Color {
        switch self {
        case .selfCare:
            return Color(red: 0.66, green: 0.76, blue: 0.79)
        case .social:
            return Color(red: 0.76, green: 0.77, blue: 0.74)
        case .needs:
            return Color(red: 0.82, green: 0.67, blue: 0.79)
        }
    }

}

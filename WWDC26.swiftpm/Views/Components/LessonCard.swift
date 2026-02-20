import SwiftUI

struct LessonCard: View {
    let lesson: Lesson
    var isSelected: Bool
    var isUnlocked: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 9.06415) {
                Image(systemName: "star.fill")
                  .frame(maxWidth: .infinity, minHeight: 28.28249, maxHeight: 28.28249)
                  .foregroundColor(Color.white)
            }
            .padding(10)
            .frame(width: 50, height: 50, alignment: .topLeading)
            .background(isUnlocked ? Color.cyan : Color.gray)
            .cornerRadius(27.19244)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
              RoundedRectangle(cornerRadius: 27.19244)
                .inset(by: -1)
                .stroke(.white, lineWidth: 2)
            )
              
        }
        .padding()
        .scaleEffect(isSelected ? 2 : 1.0)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isSelected)
    }
}
#Preview {
    LessonCard(lesson: Lesson(
        title: "Needs",
        phrases: [ Phrase(
            nativeText: "Hi",
            targetText: "Olá",
            audioFileName: "hello_audio",
            imageName: "hand.wave",
            category: .social
        ) ],
        description: "Learn some basic needs in Portuguese",
        category: .needs,
        isCompleted: false,
        order: 2,
        
    ), isSelected: true, isUnlocked: true )
}

import SwiftUI

struct LessonCard: View {
    let lesson: Lesson
    var isSelected: Bool
    var isUnlocked: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                VStack(alignment: .center, spacing: 9.06415) {
                    Image(systemName: isUnlocked ? lesson.category.iconName : "lock.fill")
                        .resizable()
                        .scaledToFit()
                      .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                      .foregroundColor(Color.white)
                }
                .padding(10)
                .frame(width: 140, height: 140, alignment: .center)
                .background(isUnlocked ? lesson.category.categoryColor : lesson.category.categoryColorLocked)
                .cornerRadius(80)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                .overlay(
                  RoundedRectangle(cornerRadius: 80)
                    .inset(by: -1)
                    .stroke(.white, lineWidth: 6)
                )
                
                HStack(alignment: .center) {
                    Text(lesson.title)
                        .font(
                            .system(size: 25, weight: .bold, design: .rounded)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                .padding(.horizontal,30)
                .padding(.vertical, 10)
                .background(isUnlocked ? lesson.category.categoryColor : lesson.category.categoryColorLocked)
                .cornerRadius(80)
                .shadow(color:  isUnlocked ? lesson.category.categoryColor.darker() : lesson.category.categoryColorLocked.darker(), radius: 4, x: 0, y: 6)
               
            }
        }
        .padding()
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isSelected)
    }
}
//#Preview {
//    LessonCard(lesson: Lesson(
//        title: "Needs",
//        phrases: [ Phrase(
//            nativeText: "Hi",
//            targetText: "Olá",
//            audioFileName: "hello_audio",
//            imageName: "hand.wave",
//            category: .social
//        ) ],
//        description: "Learn some basic needs in Portuguese",
//        category: .needs,
//        isCompleted: false,
//        order: 2
//        
//    ), isSelected: true, isUnlocked: false )
//}

import SwiftUI

struct LessonView: View {
    @StateObject var viewModel: LessonViewModel
    
    init(lesson: Lesson) {
        _viewModel = StateObject(wrappedValue: LessonViewModel(lesson: lesson))
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text(viewModel.lesson.description)
                .font(.subheadline)
                .padding()
            
            List(viewModel.lesson.phrases) { phrase in
                PhraseRow(phrase: phrase)
            }
            .listStyle(.plain)
        }
        .navigationTitle(viewModel.lesson.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LessonView(lesson: Lesson(
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
        order: 2
    ) )
}

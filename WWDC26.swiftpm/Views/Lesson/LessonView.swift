import SwiftUI


struct LessonView: View {
    @StateObject var viewModel: LessonViewModel
    @Environment(\.dismiss) private var dismiss
    var onLessonCompleted: ((UUID) -> Void)?

    init(lesson: Lesson, onLessonCompleted: ((UUID) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: LessonViewModel(lesson: lesson))
        self.onLessonCompleted = onLessonCompleted
    }
    
    var body: some View {
        
        ZStack {
            Image("BG")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                if viewModel.isLastStep {
                    LessonCompletionView {
                        viewModel.completeLesson()
                        
                        onLessonCompleted?(viewModel.lesson.id)
                        
                        dismiss()
                    }
                } else if viewModel.isInQuizMode {
                    LessonHeaderView(
                        currentStep: viewModel.isLastStep
                        ? (viewModel.lesson.phrases.count * 2) - 1
                        : (viewModel.isInQuizMode ? viewModel.currentIndex + viewModel.lesson.phrases.count : viewModel.currentIndex),
                        totalSteps: viewModel.lesson.phrases.count * 2
                    )
                    QuizView(viewModel: viewModel)
                    
                } else if let phrase = viewModel.currentPhrase {
                    LessonHeaderView(
                        currentStep: viewModel.isLastStep
                        ? (viewModel.lesson.phrases.count * 2) - 1
                        : (viewModel.isInQuizMode ? viewModel.currentIndex + viewModel.lesson.phrases.count : viewModel.currentIndex),
                        totalSteps: viewModel.lesson.phrases.count * 2
                    )
                    PhraseStepView(viewModel: viewModel, phrase: phrase)
                }
                
                Spacer()
                
                if viewModel.stepFinished && !viewModel.isInQuizMode && !viewModel.isLastStep {
                    HStack {
                        Button(viewModel.isLastStep ? "Finish" : "Next") {
                            if viewModel.isLastStep {
                                dismiss()
                            } else {
                                viewModel.next()
                            }
                        }
                        .font(
                            .system(size: 40, weight: .bold, design: .rounded)
                        )
                        .foregroundColor(.white)
                        .padding(.horizontal, 54)
                        .padding(.vertical, 15)
                        .frame(width: 500, height: 90, alignment: .center)
                        .background(Color(red: 0.5, green: 0.76, blue: 0.26))
                        .cornerRadius(30)
                        .shadow(color: Color(red: 0.3, green: 0.57, blue: 0.04), radius: 2.6, x: 0, y: 14.2735)
                    }
                    .padding()
                }
                Spacer()
            }
            .navigationTitle(viewModel.lesson.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LessonHeaderView: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
            
        HStack(spacing: 15) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Capsule()
                    .fill(index <= currentStep ? Color.pink : Color.gray.opacity(0.3))
                    .frame(height: 20)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                    .animation(.spring(), value: currentStep)
            }
        }
        .padding(.horizontal ,40)
        .padding()
    }
}

struct LessonCompletionView: View {
    var onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .scaleEffect(1.2)
                .padding()
            
            Text("Lição Concluída!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
            
            Text("Você aprendeu novas frases hoje.")
                .font(.body)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                onDismiss()
            }
        }
    }
}


struct PhraseStepView: View {
    @ObservedObject var viewModel: LessonViewModel
    let phrase: Phrase
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hear the translation to:")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.top, 40)
            
            Spacer()
            
            FlashCardView(phrase: phrase)
            
            Spacer()
            
            HiddenTranslationView(
                text: phrase.targetText,
                isRevealed: viewModel.stepFinished
            )
            
            Spacer()
            
            AudioPillView(phrase: phrase) {
                withAnimation {
                    viewModel.stepFinished = true
                }
            }
            
            Spacer()
                        
        }
    }
}

struct HiddenTranslationView: View {
    let text: String
    var isRevealed: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            if isRevealed {
                Text(text)
                    .font(.system(size: 40, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.bottom, 35)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 445.75, y: 0))
            }
            .stroke(
                Color(red: 0.05, green: 0.66, blue: 0.87),
                style: StrokeStyle(
                    lineWidth: 8,
                    lineCap: .round,
                    dash: [28, 40]
                )
            )
            .frame(width: 445, height: 2)
        }
        .frame(height: 60)
    }
}

//#Preview {
//    LessonView(lesson: Lesson(
//        title: "My body",
//        phrases: [
//            Phrase(nativeText: "I am in pain", targetText: "Estou com dor", audioFileName: "dor_audio", imageName: "bandage.fill", category: .selfCare),
//            Phrase(nativeText: "My head hurts", targetText: "Minha cabeça dói", audioFileName: "cabeca_audio", imageName: "cross.case.fill", category: .selfCare),
//            Phrase(nativeText: "My tummy hurts", targetText: "Minha barriga dói", audioFileName: "barriga_audio", imageName: "pills.fill", category: .selfCare),
//            Phrase(nativeText: "I am sick", targetText: "Estou doente", audioFileName: "doente_audio", imageName: "thermometer", category: .selfCare)
//        ],
//        description: "Learn to tell when something is wrong with your body.",
//        category: .selfCare,
//        order: 1
//        
//    ) )
//}

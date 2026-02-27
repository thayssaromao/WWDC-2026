import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: LessonViewModel
    @State private var showResultSheet = false
    var phrase: Phrase { viewModel.lesson.phrases[viewModel.currentIndex] }
    
    @State private var shuffledWords: [String] = []
    @State private var selectedWords: [String] = []
    
    var body: some View {
        ZStack {
            Image("BG")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Choose the translation to:")
                  .font(.system(size: 34, weight: .bold, design: .rounded))
                  .padding(.top, 40)
                  .foregroundColor(.black)
                
                Spacer()
                
                FlashCardView(phrase: phrase)
                
                Spacer()
                
                AudioPillView(phrase: phrase) {
                    withAnimation {
                        viewModel.stepFinished = true
                    }
                }
                
                Spacer()
                
                HStack {
                    if selectedWords.isEmpty {
                        Text("Select the words below")
                            .font(.system(size: 20))
                            .foregroundColor(.gray.opacity(0.8))
                    } else {
                        ForEach(selectedWords, id: \.self) { word in
                            Text(word)
                                .font(.system(size:25, weight: .medium, design: .rounded))
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                                .onTapGesture {
                                    withAnimation {
                                        selectedWords.removeAll { $0 == word }
                                        shuffledWords.append(word)
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 40)
                .frame(width: 700, alignment: .center)
                .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                .cornerRadius(40)
                .shadow(color: .black.opacity(0.35), radius: 2, x: 0, y: 4)
                
                Spacer()
                
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 15) {
                        ForEach(shuffledWords, id: \.self) { word in
                            Button(action: {
                                withAnimation {
                                    selectedWords.append(word)
                                    shuffledWords.removeAll { $0 == word }
                                }
                            }) {
                                Text(word)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .padding()
                                    .lineLimit(1)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(20)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .frame(maxWidth: 660)
                
                Spacer()
                
                Button(action: {
                    checkAnswer()
                }) {
                    Text("Check Answer")
                        .font(.system(size: 35, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 54)
                        .padding(.vertical, 15)
                        .frame(width: 420, height: 80, alignment: .center)
                        .background(Color(red: 0.5, green: 0.76, blue: 0.26))
                        .cornerRadius(30)
                        .shadow(color: Color(red: 0.3, green: 0.57, blue: 0.04), radius: 2.6, x: 0, y: 14.2735)
                }
                
                Spacer()
            }
            
            .onAppear {
                setupQuiz()
            }
            .onChange(of: viewModel.currentIndex) { 
                selectedWords.removeAll()
                setupQuiz()
            }
            .sheet(isPresented: $showResultSheet) {
                let isCorrect = selectedWords.joined(separator: " ") == phrase.targetText
                    
                    QuizResultSheetView(
                        isCorrect: isCorrect,
                        targetText: phrase.targetText,
                        viewModel: viewModel,
                        showResultSheet: $showResultSheet,
                        selectedWords: $selectedWords,
                        onRetry: {
                            setupQuiz()
                        }
                    )
            }
        }
        }
    
    func setupQuiz() {
            let targetText = phrase.targetText
            var words: [String] = targetText.split(separator: " ").map { String($0) }
            
            let allPhrases = viewModel.lesson.phrases
            let allTargets = allPhrases.map { $0.targetText }
            let joinedText = allTargets.joined(separator: " ")
            let splitText = joinedText.split(separator: " ")
            let otherWords: [String] = splitText.map { String($0) }
            
            let backups: [String] = ["eu", "você", "bom", "olá", "sim", "não", "água", "frio", "casa"]
            
            var pool: [String] = otherWords + backups
            
            pool = pool.filter { candidate in
                return !words.contains(candidate)
            }
            
            let shuffledPool = pool.shuffled()
            let randomExtras = Array(shuffledPool.prefix(4))
            
            words.append(contentsOf: randomExtras)
            shuffledWords = words.shuffled()
        }
    
    func checkAnswer() {
        showResultSheet = true
    }
}

struct QuizResultSheetView: View {
    let isCorrect: Bool
    let targetText: String
    
    @ObservedObject var viewModel: LessonViewModel
    @Binding var showResultSheet: Bool
    @Binding var selectedWords: [String]
    
    var onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(isCorrect ? "Congratulations!" : "Almost there!")
                .font(.system(size: 40, weight: .bold, design: .rounded))
            
                Image(isCorrect ? "rightImg" : "almostImg")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 400)
            
                Text(isCorrect ? "You got the sentence right." : "Try again, you can do it!")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .padding()
            
            Button(action: {
                showResultSheet = false
                
                if isCorrect {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.stepFinished = true
                        viewModel.next()
                    }
                } else {
                    selectedWords.removeAll()
                    onRetry()
                }
            }) {
                Text(isCorrect ? "Next" : "Try Again!")
                    .font(.system(size: 35, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 54)
                    .padding(.vertical, 15)
                    .frame(width: 420, height: 80, alignment: .center)
                    .background(isCorrect ? Color.GREEN : Color.BLUE)
                    .cornerRadius(30)
                    .shadow(color: isCorrect ? Color.GREEN.darker() : Color.BLUE.darker(), radius: 2.6, x: 0, y: 14.2735)
            }
            
            Spacer()
        }
        .padding()
        // .presentationDetents([.fraction(0.4)])
    }
}

#Preview {
  QuizView(viewModel: LessonViewModel(lesson:
    Lesson(
        title: "My body",
        phrases: [
            Phrase(nativeText: "My tummy hurts", targetText: "Minha barriga dói", audioFileName: "barriga_audio", imageName: "pills.fill", category: .selfCare),
            Phrase(nativeText: "I am in pain", targetText: "Estou com dor", audioFileName: "dor_audio", imageName: "bandage.fill", category: .selfCare),
            Phrase(nativeText: "My head hurts", targetText: "Minha cabeça dói", audioFileName: "cabeca_audio", imageName: "cross.case.fill", category: .selfCare),
            Phrase(nativeText: "I am sick", targetText: "Estou doente", audioFileName: "doente_audio", imageName: "thermometer", category: .selfCare)
        ],
        description: "Learn to tell when something is wrong with your body.",
        category: .selfCare,
        order: 1
        
    )))
}

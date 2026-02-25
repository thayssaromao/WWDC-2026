import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: LessonViewModel
    @State private var showResultSheet = false
    var phrase: Phrase { viewModel.lesson.phrases[viewModel.currentIndex] }
    
    @State private var shuffledWords: [String] = []
    @State private var selectedWords: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Choose the translation to:")
              .font(
                Font.custom("Montserrat", size: 34)
                  .weight(.medium)
                
              )
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
            
            Spacer().frame(height: 30)
            
            HStack {
                if selectedWords.isEmpty {
                    Text("Select the words below")
                        .foregroundColor(.gray.opacity(0.5))
                } else {
                    ForEach(selectedWords, id: \.self) { word in
                        Text(word)
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
            .frame(height: 90)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            
            Spacer()
            
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 15) {
                    ForEach(shuffledWords, id: \.self) { word in
                        Button(action: {
                            withAnimation {
                                selectedWords.append(word)
                                shuffledWords.removeAll { $0 == word }
                            }
                        }) {
                            Text(word)
                                .font(Font.custom("SF Compact", size: 23))
                                .padding()
                                .frame(minWidth: 100)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(20)
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(maxWidth: 500)
            
            Spacer()
            
            Button("Check Answer") {
                checkAnswer()
            }
            .font(Font.custom("SF Compact", size: 35))
            .foregroundColor(.white)
            .padding(.horizontal, 54)
            .padding(.vertical, 15)
            .frame(width: 420, height: 80, alignment: .center)
            .background(Color(red: 0.5, green: 0.76, blue: 0.26))
            .cornerRadius(30)
            .shadow(color: Color(red: 0.3, green: 0.57, blue: 0.04), radius: 2.6, x: 0, y: 14.2735)
            
            Spacer()
        }
        
        .onAppear {
            setupQuiz()
        }
        .onChange(of: viewModel.currentIndex) { _ in
            selectedWords.removeAll()
            setupQuiz()
        }
        .sheet(isPresented: $showResultSheet) {
            VStack(spacing: 20) {
                let isCorrect = selectedWords.joined(separator: " ") == phrase.targetText
                
                Text(isCorrect ? "Parabéns!" : "Quase lá")
                    .font(.largeTitle)
                    .foregroundColor(isCorrect ? .green : .red)
                
                Text(isCorrect ? "Você acertou a frase!" : "A resposta correta é: \(phrase.targetText)")
                    .padding()
                
                Button("Next") {
                    showResultSheet = false
                    if isCorrect {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            viewModel.stepFinished = true
                            viewModel.next()
                        }
                    } else {
                        selectedWords.removeAll()
                        setupQuiz()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            //.presentationDetents([.fraction(0.4)]) // Sheet ocupa 40% da tela
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

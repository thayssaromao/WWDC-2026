import SwiftUI

struct MicrophoneButton: View {
    @ObservedObject var viewModel: LessonViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                if viewModel.speechRecognizer.isRecording {
                    viewModel.stopListening()
                } else {
                    viewModel.startListening()
                }
            }) {
                ZStack {
                    if viewModel.speechRecognizer.isRecording {
                        Circle()
                            .fill(Color.red.opacity(0.2))
                            .frame(width: 140, height: 140)
                            .scaleEffect(1.2)
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: viewModel.speechRecognizer.isRecording)
                    }
                    
                    Image(systemName: viewModel.speechRecognizer.isRecording ? "stop.fill" : "mic.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(viewModel.speechRecognizer.isRecording ? Color.red : Color.blue)
                        .clipShape(Circle())
                        .shadow(color: .blue.opacity(0.4), radius: 15, x: 0, y: 10)
                }
            }
            
            if !viewModel.speechRecognizer.transcript.isEmpty {
                Text(viewModel.speechRecognizer.transcript)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            }
        }
    }
}


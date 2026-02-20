import SwiftUI

struct PhraseRow: View {
    @StateObject private var viewModel: PhraseViewModel
    
    init(phrase: Phrase) {
        _viewModel = StateObject(wrappedValue: PhraseViewModel(phrase: phrase))
    }
    
    var body: some View {
        
        HStack {
            
            Image(systemName: viewModel.phrase.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(viewModel.phrase.nativeText)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(viewModel.phrase.targetText)
                    .font(.title)
            }
            
            Spacer()
            
            Button(action : {
                viewModel.playAudio()
            }) {
                Image(systemName: "speaker.wave.2.circle.fill")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

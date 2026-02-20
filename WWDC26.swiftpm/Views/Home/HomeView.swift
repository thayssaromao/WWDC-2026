import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    HStack {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .overlay(
                        HStack(spacing: 0) {
                            ForEach(PhraseCategory.allCases) { category in
                                Text(category.rawValue.lowercased())
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(width: 80)
                                    .padding(.vertical, 8)
                                    .background(
                                        viewModel.selectedCategory == category ? Color.gray.opacity(0.4) : Color.clear
                                    )
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            viewModel.selectedCategory = category
                                        }
                                    }
                            }
                        }
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                    )
                    .padding()
                    
                    Spacer()
                    
                    if viewModel.filteredLessons.isEmpty {
                        Text("Nenhuma lição encontrada")
                            .foregroundColor(.gray)
                    } else {
                            HStack(spacing: 30) {
                                ForEach(viewModel.filteredLessons) { lesson in
                                    let isUnlocked = viewModel.isUnlocked(lesson: lesson)
                                    let isSelected = viewModel.selectedLessonId == lesson.id
                                    
                                    NavigationLink(destination: LessonView(lesson: lesson)) {
                                        LessonCard(
                                            lesson: lesson,
                                            isSelected: isSelected,
                                            isUnlocked: isUnlocked
                                        )
                                    }
                                    .disabled(!isUnlocked)
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 40)
                        }
                    
                    Spacer()

                }
            }
        }
    }
}

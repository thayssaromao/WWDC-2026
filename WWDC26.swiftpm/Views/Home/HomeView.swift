import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    let pattern: [CGFloat] = [ -180, 180, -180, 150]
    let itemHeight: CGFloat = 200
    
    func getOffset(for index: Int) -> CGFloat {
        return pattern[index % pattern.count]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
               
                VStack {
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
                                    .frame(width: 80, height: 40)
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
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                    )
                    .padding(.top, 30)
                    
                    Spacer().frame(height: 30)
                    
                    if viewModel.filteredLessons.isEmpty {
                        Text("Nenhuma lição encontrada")
                            .foregroundColor(.gray)
                            .frame(maxHeight: .infinity)
                    } else {
                        let enumeratedLessons = Array(viewModel.filteredLessons.enumerated())
                        VStack {
                            ForEach(enumeratedLessons.reversed(), id: \.element.id) { index, lesson in
                                let isUnlocked = viewModel.isUnlocked(lesson: lesson)
                                let isSelected = viewModel.selectedLessonId == lesson.id
                                
                                NavigationLink(destination: LessonView(
                                    lesson: lesson,
                                    onLessonCompleted: { completedId in
                                        viewModel.markLessonAsCompleted(id: completedId)
                                    }
                                )) {
                                    LessonCard(
                                        lesson: lesson,
                                        isSelected: isSelected,
                                        isUnlocked: isUnlocked
                                    )
                                }
                                .allowsHitTesting(isUnlocked)
                                .buttonStyle(PlainButtonStyle())
                                .offset(x: getOffset(for: index))
                                .frame(height: itemHeight)
                                .zIndex(isSelected ? 1 : 0)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            TracingPath(count: enumeratedLessons.count, stepY: itemHeight)
                                .stroke(
                                    Color.gray.opacity(0.5),
                                    style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round, dash: [20, 30])
                                )
                        )
                        .padding(.vertical, 50)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct TracingPath: Shape {
    let count: Int
    let stepY: CGFloat
    let pattern: [CGFloat] = [ -180, 180, -180, 150]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard count > 0 else { return path }

        let centerX = rect.width / 2
        let startY = rect.height - (stepY / 2)

        var currentPoint = CGPoint(
            x: centerX + pattern[0],
            y: startY
        )

        path.move(to: currentPoint)

        for i in 1..<count {
            let nextPoint = CGPoint(
                x: centerX + pattern[i % pattern.count],
                y: startY - CGFloat(i) * stepY
            )

            let cp1 = CGPoint(
                x: currentPoint.x,
                y: currentPoint.y - stepY / 0.78
            )
            let cp2 = CGPoint(
                x: nextPoint.x,
                y: nextPoint.y + stepY / 1
            )

            path.addCurve(to: nextPoint, control1: cp1, control2: cp2)
            currentPoint = nextPoint
        }

        return path
    }
}

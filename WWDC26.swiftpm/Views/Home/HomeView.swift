import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Namespace private var animation
    
    let pattern: [CGFloat] = [ -180, 180, -180, 150]
    let itemHeight: CGFloat = 200
    
    func getOffset(for index: Int) -> CGFloat {
        return pattern[index % pattern.count]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(viewModel.selectedCategory.Background)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
               
                VStack {
                    HStack {
                        ZStack {
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 70, height: 60)
                              .background(viewModel.selectedCategory.categoryColor)
                              .cornerRadius(15)
                              .shadow(
                                  color: viewModel.selectedCategory.categoryColor.darker(by: 0.3),
                                  radius: 0,
                                  x: 0,
                                  y: 10
                              )
                            
                            Image(systemName: "list.bullet")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .overlay(
                        HStack(spacing: 0) {
                            ForEach(PhraseCategory.allCases) { category in
                                Text(category.rawValue.lowercased())
                                    .font(
                                        .system(size: 22, weight: .bold, design: .rounded)
                                    )
                                    .foregroundColor(viewModel.selectedCategory == category ? Color.white : viewModel.selectedCategory.categoryColor)
                                    .frame(width: 110, height: 40)
                                    .padding(.vertical, 8)
                                    .background(
                                        ZStack {
                                            if viewModel.selectedCategory == category {
                                                Capsule()
                                                    .fill(category.categoryColor)
                                                    .matchedGeometryEffect(id: "liquidBackground", in: animation)
                                            }
                                        }
                                    )
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.5)) {
                                            viewModel.selectedCategory = category
                                        }
                                    }
                            }
                        }
                        .padding(10)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Capsule())
                    )
                    .padding()
                    
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
                                    viewModel.selectedCategory.categoryColor,
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

extension Color {
    func darker(by amount: CGFloat = 0.3) -> Color {
        let uiColor = UIColor(self)
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        if uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return Color(hue: Double(h),
                         saturation: Double(s),
                         brightness: Double(max(b - amount, 0)),
                         opacity: Double(a))
        }
        return self
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

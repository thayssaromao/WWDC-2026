import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Namespace private var animation
    
    let pattern: [CGFloat] = [-200, 200, -160, 200]
    let itemHeight: CGFloat = 235
    
    @State private var showMenu = false
    
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
                    Spacer()
                    
                    HStack {

                        HStack {
                            Button(action: {
                                showMenu = true
                            }) {
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
                            }
                            .sheet(isPresented: $showMenu) {
                                MenuView()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
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
                    
                    Spacer()
                    
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
                            TracingPath(count: enumeratedLessons.count, stepY: itemHeight, pattern: pattern)
                                .stroke(
                                    viewModel.selectedCategory.categoryColor,
                                    style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round, dash: [60, 55])
                                )
                        )
                        .padding(.vertical, 50)
                    }
                }
                .padding()
            }
        }
    }
}

struct MenuView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Apprenticeship")) {
                    HStack {
                        Label("Current Language", systemImage: "globe")
                        Spacer()
                        Text("Português")
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("About")) {
                    NavigationLink {
                        VStack{
                            Text("Created by:")
                                .font(.system(size: 30, weight: .bold,design: .rounded))
                            
                            Text("Thayssa Romão")
                            Image("euuuu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                            Spacer()
                        }
            
                    } label: {
                        Label("Credits", systemImage: "person.2.fill")
                    }
                    
                    Label("Version 1.0", systemImage: "info.circle")
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
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
    let pattern: [CGFloat]

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

        for i in 0..<count {
            
            if i < count - 1 {
                let nextPoint = CGPoint(
                    x: centerX + pattern[(i + 1) % pattern.count],
                    y: startY - CGFloat(i + 1) * stepY
                )
                
                var cp1: CGPoint
                var cp2: CGPoint
                
                switch i {
                case 0:
                    cp1 = CGPoint(x: currentPoint.x + 350, y: currentPoint.y)
                    cp2 = CGPoint(x: nextPoint.x, y: nextPoint.y + 150)
                    
                case 1:
                    cp1 = CGPoint(x: currentPoint.x, y: currentPoint.y - 200)
                    cp2 = CGPoint(x: nextPoint.x + 150, y: nextPoint.y + 20)
                    
                case 2:
                    cp1 = CGPoint(x: currentPoint.x - 300, y: currentPoint.y - 300)
                    cp2 = CGPoint(x: nextPoint.x - 180, y: nextPoint.y - 250)
                    
                default:
                    cp1 = CGPoint(x: currentPoint.x, y: currentPoint.y - stepY / 2)
                    cp2 = CGPoint(x: nextPoint.x, y: nextPoint.y + stepY / 2)
                }
                
                path.addCurve(to: nextPoint, control1: cp1, control2: cp2)
                currentPoint = nextPoint
            }
            
            if i == count - 1 {
                let exitPoint = CGPoint(
                    x: rect.width + 100, 
                    y: currentPoint.y - 100
                )
                
                let cpExit = CGPoint(x: currentPoint.x + 150, y: currentPoint.y + 200)
                
                path.addQuadCurve(to: exitPoint, control: cpExit)
            }
        }

        return path
    }
}

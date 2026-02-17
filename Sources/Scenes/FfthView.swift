//
//  FthView.swift
//  NameEntering
//
//  Created by Егор Батяев on 17.02.2026.
//

import SwiftUI

struct FfthView: View {
    
    // MARK: - Properties
    
    var name: String?
    @State private var data = ["Понедельник", "Вторник", "Среда", "Четверг",
                               "Пятница", "Суббота", "Воскресенье"]
    @State private var selectedDay: String = ""
    
    private let colors: [Color] = [
        .red, .orange, .yellow, .green,
        .blue, .indigo, .purple
    ]
    
    // MARK: - Layout
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(Array(data.enumerated()), id: \.element) { index, day in
                        DayCellView(
                            day: day,
                            color: colors[index % colors.count],
                            index: index + 1,
                            isSelected: selectedDay == day,
                            onTap: {
                                // ЭТО ВАЖНО - обновляем selectedDay при нажатии
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    selectedDay = day
                                }
                                print("Выбрана ячейка: \(day)")
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
            
            Spacer()
            
            Text(selectedDay.isEmpty ? "Выберите день" : selectedDay)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 36)
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
                .cornerRadius(12)
                .scaleEffect(selectedDay.isEmpty ? 0.9 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedDay)
                .padding(.bottom, 20)
        }
        .navigationTitle(name != nil ? "Привет, \(name!)!" : "Дни недели")
        .background(Color(.systemBackground))
        .onChange(of: selectedDay) { newValue in
            print("selectedDay изменился на: \(newValue)")
        }
    }
}

// MARK: - Day Cell View

struct DayCellView: View {
    
    let day: String
    let color: Color
    let index: Int
    let isSelected: Bool
    let onTap: () -> Void // Замыкание для обработки нажатия
    
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .frame(height: 120)
                .shadow(color: color.opacity(0.3), radius: isPressed ? 8 : 4, x: 0, y: isPressed ? 4 : 2)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: isSelected ? 3 : 0)
                )
            
            VStack(spacing: 8) {
                Text("\(index)")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white.opacity(0.9))
                
                Text(day)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 8)
        }
        .onTapGesture {
            // Анимация нажатия
            withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            // Вызываем замыкание, которое обновит selectedDay в родительской View
            onTap()
            
            // Возвращаем анимацию обратно
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isPressed = false
                }
            }
        }
    }
}

// MARK: - Preview

struct FfthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FfthView(name: "Егор")
        }
    }
}

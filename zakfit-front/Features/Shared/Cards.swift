//
//  MealCard.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 04/12/2025.
//

import SwiftUI

struct MealCard: View {
    let title: String
    let kcal: Int
    let protein: Int
    let carbs: Int
    let fat: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text("\(kcal) kcal | Protein: \(protein)g | Carbs: \(carbs)g | Fat: \(fat)g")
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 96, alignment: .leading)
        .background(color)
        .cornerRadius(12)
    }
}

struct MacroCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.custom("Montserrat-SemiBold", size: 20))

            Text(value)
                .font(.custom("Montserrat-SemiBold", size: 18))
        }
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity, minHeight: 116)
        .background(color)
        .cornerRadius(16)
    }
}


struct MealItemRow: View {
    let item: MealItem

    var body: some View {
        HStack {
            Text(item.name)
                .font(.body)
                .foregroundColor(.white)

            Spacer()

            Text("\(item.kcalServing)kcal | Protein: \(item.proteinServing)g | Carbs: \(item.carbsServing)g | Fat: \(item.fatServing)g")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.04))
        .cornerRadius(10)
    }
}

struct CustomMealItemRow: View {
    let item: CustomMealItem

    var body: some View {
        HStack {
            Text(item.name)
                .font(.body)
                .foregroundColor(.white)

            Spacer()

            Text("\(item.kcalServing)kcal | Protein: \(item.proteinServing)g | Carbs: \(item.carbsServing)g | Fat: \(item.fatServing)g")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.04))
        .cornerRadius(10)
    }
}

struct ActivityCard: View {
    let typeName: String
    let duration: Int
    let calories: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(typeName)
                .font(.custom("Montserrat-SemiBold", size: 20))
            
            Text("Duration: \(duration) min")
                .font(.custom("Montserrat-SemiBold", size: 16))
            
            Text("Calories: \(calories) kcal")
                .font(.custom("Montserrat-SemiBold", size: 16))
        }
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity, minHeight: 116)
        .background(color)
        .cornerRadius(16)
    }
}

struct ActivityRow: View {
    let activity: Activity

    var body: some View {
        HStack {
            Text("\(activity.duration) min (\(activity.activityTypeName) session)")
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
            
            Text("\(activity.caloriesBurned) kcal")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.04))
        .cornerRadius(10)
    }
}

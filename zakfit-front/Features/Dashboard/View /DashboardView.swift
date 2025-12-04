//
//  DashboardView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct DashboardView: View {
    @Environment(AppState.self) private var appState
    @Environment(MealViewModel.self) private var mealVM
    @Environment(ActivityViewModel.self) private var activityVM

    private let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let weekDates = ["01", "02", "03", "04", "05", "06", "07"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    // HEADER
                    Text("Hello Samara,")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    // WEEK DAYS
                    HStack {
                        ForEach(0..<7) { i in
                            VStack(spacing: 4) {
                                Text(weekDays[i])
                                    .foregroundColor(.gray)
                                    .font(.caption)

                                Text(weekDates[i])
                                    .font(.headline)
                                    .foregroundColor(i == 4 ? .white : .gray)

                                if i == 4 { // Highlight current day
                                    Circle()
                                        .fill(Color.accentColor)
                                        .frame(width: 6, height: 6)
                                        .padding(.top, 2)
                                } else {
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(width: 6, height: 6)
                                        .padding(.top, 2)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }

                    // KCAL OVERVIEW
                    HStack {
                        VStack {
                            Image("orange-food")
                            Text("965")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                            Text("EATEN")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)

                        // MIDDLE CIRCLE
                        ZStack {
                            Circle()
                                .foregroundStyle(.white)
                                .frame(width: 126, height: 126)
                            Circle()
                                .stroke(lineWidth: 14)
                                .foregroundColor(Color.accent.opacity(0.3))

                            Circle()
                                .trim(from: 0, to: 0.78)
                                .stroke(Color.accent, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                                .rotationEffect(.degrees(-90))

                            VStack(spacing: 4) {
                                Image("orange-lightning")
                                Text("1645")
                                    .font(.title.bold())
                                    .foregroundColor(.black)
                                Text("KCAL LEFT")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(width: 140, height: 140)

                        VStack {
                            Image("orange-fire")
                            Text("108")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                            Text("BURNED")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 10)

                    // MACROS
                    VStack(spacing: 16) {

                        macroRow(
                            label: "CARBS",
                            left: "150g left",
                            color: .verde
                        )

                        macroRow(
                            label: "PROTEIN",
                            left: "118g left",
                            color: .lilas
                        )

                        macroRow(
                            label: "FAT",
                            left: "75g left",
                            color: .amarelo
                        )
                    }

                    // ACTION BUTTONS
                    VStack(spacing: 16) {

                        NavigationLink(destination: MealView()) {
                            dashboardCard(
                                title: "Add a meal",
                                background: Color.amarelo,
                                imageName: "rabanete"
                            )
                        }

                        NavigationLink(destination: ActivityView()) {
                            dashboardCard(
                                title: "Log an exercise",
                                background: Color.lilas,
                                imageName: "orange"
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: - Components

    @ViewBuilder
    private func macroRow(label: String, left: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .foregroundColor(.white)
                Spacer()
                Text(left)
                    .foregroundColor(.gray)
            }
            .font(.caption)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 6)

                Capsule()
                    .fill(color)
                    .frame(width: 120, height: 6)
            }
        }
    }

    @ViewBuilder
    private func dashboardCard(title: String, background: Color, imageName: String) -> some View {
        ZStack(alignment: .topTrailing) {

           
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.title2.bold())
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 130)
            .background(background)
            .cornerRadius(20)

            // IMAGE FLOATING OUTSIDE
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .offset(x: -10, y: -22)   // negative Y makes it escape the card
        }
    }


}

#Preview {
    let app = AppState()
    let mealVM = MealViewModel(appState: app)
    let actVM =  ActivityViewModel(appState: app)

    NavigationStack {
        DashboardView()
            .environment(app)
            .environment(mealVM)
            .environment(actVM)
    }
}


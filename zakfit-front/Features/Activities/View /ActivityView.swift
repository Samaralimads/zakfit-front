//
//  ActivityView.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 02/12/2025.
//

import SwiftUI

struct ActivityView: View {
    @Environment(AppState.self) private var appState
    @Environment(ActivityViewModel.self) var vm

    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center, spacing: 24) {
                    
                    Text("Activity")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    HStack {
                        Button(action: {
                            // TODO: handle previous day
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        Spacer()
                        Text("Today")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            // TODO: handle next day
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                    }
                    .padding()
                    .padding(.bottom, 20)
                    
                    // Total calories burned today
                    VStack(){
                        Image("orange-fire")
                    Text("\(vm.totalCaloriesToday) kcal")
                        .font(.custom("Montserrat-Medium", size: 32))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                       
                        Text("BURNED")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                           

                    }
                    
                    // Lazy grid for activity cards
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(vm.activitySummary) { summary in
                            ActivityCard(
                                typeName: summary.typeName,
                                duration: summary.totalDuration,
                                calories: summary.totalCalories,
                                color: color(for: summary.typeName)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ForEach(vm.activities) { activity in
                            ActivityRow(activity: activity)
                        }
                    }
                 
                }
                .padding(.top, 20)
            }
            
            // Loading overlay
            if vm.isLoading {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                ProgressView("Loading activities...")
                    .foregroundColor(.white)
            }
        }
        .task {
            await vm.loadAll()
        }
    }
    
    // Color for each activity type
    private func color(for typeName: String) -> Color {
        switch typeName.lowercased() {
        case "yoga":
            return .lilas
        case "strength":
            return .verde
        case "cardio":
            return .amarelo
        default:
            return .accent
        }
    }
}

#Preview {
    let appState = AppState()
    let activityVM = ActivityViewModel(appState: appState)
    ActivityView()
        .environment(appState)
        .environment(activityVM)
}


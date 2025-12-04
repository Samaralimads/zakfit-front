//
//  ActivityViewModel.swift
//  zakfit-front
//
//  Created by Samara Lima da Silva on 04/12/2025.
//

import Foundation

@Observable
final class ActivityViewModel {
    
    private let appState: AppState
    
    var activities: [Activity] = []
    var activityTypes: [ActivityType] = []
    
    var token: String? { appState.token }
    
    var activitySummary: [ActivitySummary] {
        var summary: [ActivitySummary] = []

        for type in activityTypes {
            // Get all activities of this type
            let activitiesOfType = activities.filter { $0.activityTypeId == type.id }

            // Sum duration and calories
            let totalDuration = activitiesOfType.reduce(0) { $0 + $1.duration }
            let totalCalories = activitiesOfType.reduce(0) { $0 + $1.caloriesBurned }

            // Add summary
            summary.append(
                ActivitySummary(
                    typeId: type.id!,
                    typeName: type.activity,
                    totalDuration: totalDuration,
                    totalCalories: totalCalories
                )
            )
        }

        return summary
    }

    
    var totalCaloriesToday: Int {
        activities.reduce(0) { $0 + $1.caloriesBurned }
    }
    
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Init
    init(appState: AppState) {
        self.appState = appState
        Task { await loadAll() }
    }
    
    // MARK: - Load activities and types
    func loadAll() async {
        guard let token else {
            errorMessage = "User not logged in"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let types = ActivityService.getTypes()
            async let acts = ActivityService.getAll(token: token)
            
            let (fetchedTypes, fetchedActivities) = try await (types, acts)
            
            await MainActor.run {
                self.activityTypes = fetchedTypes
                self.activities = fetchedActivities
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    // MARK: - Create activity
        func addActivity(_ activity: Activity) async {
            guard let token else { return }
            isLoading = true
            defer { isLoading = false }
            
            do {
                let created = try await ActivityService.create(token: token, activity: activity)
                await MainActor.run {
                    self.activities.append(created)
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        
        // MARK: - Delete activity
    func deleteActivity(_ activity: Activity) async {
        guard let token = token else { return }  
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await ActivityService.delete(token: token, id: activity.id)
            await MainActor.run {
                self.activities.removeAll { $0.id == activity.id }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    }

    // MARK: - Helper struct for summary
    struct ActivitySummary: Identifiable {
        var id: UUID { typeId }
        let typeId: UUID
        let typeName: String
        let totalDuration: Int
        let totalCalories: Int
    }

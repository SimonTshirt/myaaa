import Foundation
import Combine

class UserSettingsViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var goal: String = ""
    @Published var notificationsEnabled: Bool = false
    @Published var notificationFrequency: UserSettings.NotificationFrequency = .daily
    
    private let notificationService = NotificationService.shared
    private let settingsKey = "userSettings"
    
    init() {
        loadSettings()
    }
    
    func saveSettings() {
        let settings = UserSettings(
            name: name,
            goal: goal,
            notificationsEnabled: notificationsEnabled,
            notificationFrequency: notificationFrequency
        )
        
        // Save to UserDefaults
        if let encodedData = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encodedData, forKey: settingsKey)
        }
        
        // Schedule notifications if enabled
        if notificationsEnabled {
            notificationService.requestPermission { granted in
                if granted {
                    self.notificationService.scheduleNotifications(for: settings)
                }
            }
        }
    }
    
    private func loadSettings() {
        guard let data = UserDefaults.standard.data(forKey: settingsKey),
              let settings = try? JSONDecoder().decode(UserSettings.self, from: data) else {
            return
        }
        
        // Update published properties
        name = settings.name
        goal = settings.goal
        notificationsEnabled = settings.notificationsEnabled
        notificationFrequency = settings.notificationFrequency
    }
} 
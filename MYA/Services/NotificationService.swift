import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    private init() {}
    
    let motivationalMessages = [
        "Remember your goal: [GOAL]. Keep pushing!",
        "You've got this! [GOAL] is within reach.",
        "Don't give up on [GOAL]. Every step matters!",
        "Move your ass! [GOAL] won't achieve itself.",
        "Think about how good it will feel to achieve [GOAL].",
        "Small progress is still progress toward [GOAL]."
    ]
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func scheduleNotifications(for settings: UserSettings) {
        // First remove any existing notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        guard settings.notificationsEnabled else { return }
        
        // Create notification content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "MYA - Move Your Ass"
        
        // Schedule notifications based on frequency
        switch settings.notificationFrequency {
        case .hourly:
            scheduleHourlyNotifications(settings: settings)
        case .daily:
            scheduleDailyNotifications(settings: settings)
        case .weekly:
            scheduleWeeklyNotifications(settings: settings)
        }
    }
    
    private func getRandomMotivationalMessage(goal: String) -> String {
        let randomMessage = motivationalMessages.randomElement() ?? "Keep working on [GOAL]!"
        return randomMessage.replacingOccurrences(of: "[GOAL]", with: goal)
    }
    
    private func scheduleHourlyNotifications(settings: UserSettings) {
        let content = UNMutableNotificationContent()
        content.title = "MYA - Move Your Ass"
        content.body = getRandomMotivationalMessage(goal: settings.goal)
        content.sound = UNNotificationSound.default
        
        // Create a trigger that repeats every hour
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: "hourlyMotivation", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request)
    }
    
    private func scheduleDailyNotifications(settings: UserSettings) {
        let content = UNMutableNotificationContent()
        content.title = "MYA - Daily Motivation"
        content.body = getRandomMotivationalMessage(goal: settings.goal)
        content.sound = UNNotificationSound.default
        
        // Create date components for 9:00 AM
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0
        
        // Create the trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: "dailyMotivation", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request)
    }
    
    private func scheduleWeeklyNotifications(settings: UserSettings) {
        let content = UNMutableNotificationContent()
        content.title = "MYA - Weekly Motivation"
        content.body = getRandomMotivationalMessage(goal: settings.goal)
        content.sound = UNNotificationSound.default
        
        // Create date components for Monday at 9:00 AM
        var dateComponents = DateComponents()
        dateComponents.weekday = 2 // Monday
        dateComponents.hour = 9
        dateComponents.minute = 0
        
        // Create the trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: "weeklyMotivation", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request)
    }
} 
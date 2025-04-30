import Foundation

struct UserSettings: Codable {
    var name: String
    var goal: String
    var notificationsEnabled: Bool
    var notificationFrequency: NotificationFrequency
    
    enum NotificationFrequency: String, Codable, CaseIterable {
        case hourly = "Hourly"
        case daily = "Daily"
        case weekly = "Weekly"
    }
} 
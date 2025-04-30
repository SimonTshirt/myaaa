import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var viewModel = UserSettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "figure.run")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("MYA - Move Your Ass")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Your personal motivation assistant")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Name")
                        .font(.headline)
                    
                    TextField("Enter your name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                    
                    Text("Your Goal")
                        .font(.headline)
                    
                    TextField("What would you like to achieve?", text: $viewModel.goal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                Toggle("Enable Motivational Notifications", isOn: $viewModel.notificationsEnabled)
                    .padding()
                
                if viewModel.notificationsEnabled {
                    VStack(alignment: .leading) {
                        Text("Notification Frequency")
                            .font(.headline)
                        
                        Picker("Frequency", selection: $viewModel.notificationFrequency) {
                            ForEach(UserSettings.NotificationFrequency.allCases, id: \.self) { frequency in
                                Text(frequency.rawValue).tag(frequency)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    viewModel.saveSettings()
                }) {
                    Text("Save Preferences")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
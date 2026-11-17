import SwiftUI
import SwiftData

struct Settings: View {
    
    @Binding var settingsSheet: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Text("Availaible soon")
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close", systemImage: "xmark") {
                        settingsSheet = false
                    }
                }
            }
        }
    }
}

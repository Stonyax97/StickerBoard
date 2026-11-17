import SwiftUI
import SwiftData

@main
struct StickerBoardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Sticker.self)
    }
}

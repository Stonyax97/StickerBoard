import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var settingsSheet: Bool = false

    @Query private var stickers: [Sticker]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            VStack {
                if stickers.isEmpty {
                    ContentUnavailableView {
                        Label("No stickers", systemImage: "photo.on.rectangle.angled")
                    } description: {
                        Text("New stickers you add will appear here.")
                    }
                } else {
                    StickersView()
                }
            }
            .navigationTitle("My Stickers")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(
                        selection: $selectedPhotos,
                        maxSelectionCount: 0,
                        matching: .images
                    ) {
                        Label("Import", systemImage: "plus")
                    }
                    .onChange(of: selectedPhotos) {
                        Task {
                            await PhotoImporter().importPhotos(selectedPhotos: selectedPhotos, modelContext: modelContext)
                            selectedPhotos = []
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                ToolbarItem(placement: . topBarTrailing) {
                    Menu("More", systemImage: "ellipsis") {
                        Button("Select", systemImage: "checkmark.circle") {
                            //later
                        }
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("Settings", systemImage: "gear") {
                        settingsSheet.toggle()
                    }
                    .sheet(isPresented: $settingsSheet) {
                        Settings(settingsSheet: $settingsSheet)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

import SwiftUI
import Foundation
import PhotosUI
import SwiftData

struct PhotoImporter {
    
    func importPhotos(selectedPhotos: [PhotosPickerItem], modelContext: ModelContext) async {
        for photo in selectedPhotos {
            do {
                let imageData = try await photo.loadTransferable(type: Data.self)

                if let imageData {
                    let id = UUID()
                    let filename = id.uuidString + ".image"

                    guard let documentsURL = FileManager.default.containerURL(
                        forSecurityApplicationGroupIdentifier: "group.com.zmoukhsil.StickerBoard"
                    ) else {
                        print("Could not access shared container")
                        return
                    }

                    let fileURL = documentsURL.appendingPathComponent(filename)
                    try imageData.write(to: fileURL)

                    let newSticker = Sticker(
                        name: "Untitled",
                        id: id,
                        filename: filename
                    )

                    modelContext.insert(newSticker)
                }
            } catch {
                print(error)
            }
        }
    }
}

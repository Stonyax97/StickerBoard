
import SwiftUI
import UIKit
import SwiftData
import Foundation

struct StickersView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var stickers: [Sticker]

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 3
    )

    var body: some View {

        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {

                ForEach(stickers) { sticker in

                    if let documentsURL = FileManager.default.containerURL(
                        forSecurityApplicationGroupIdentifier: "group.com.zmoukhsil.StickerBoard"
                    ) {

                        let fileURL = documentsURL.appendingPathComponent(sticker.filename)

                        if let uiImage = UIImage(contentsOfFile: fileURL.path) {

                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding()
                                .contentShape(RoundedRectangle(cornerRadius: 12))
                                .contextMenu {
                                    Button("Crop", systemImage: "crop") {
                                    }

                                    Button("Delete", systemImage: "trash", role: .destructive) {
                                        do {
                                            if FileManager.default.fileExists(atPath: fileURL.path) {
                                                try FileManager.default.removeItem(at: fileURL)
                                            }

                                            modelContext.delete(sticker)

                                        } catch {
                                            print(error)
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .padding(16)
        }
    }
}

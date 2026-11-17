import SwiftUI
import SwiftData

@Model
class Sticker {
    var name: String
    var id = UUID()
    var filename: String
    
    
    init(name: String, id: UUID, filename: String) {
        self.name = name
        self.filename = filename
    }
}

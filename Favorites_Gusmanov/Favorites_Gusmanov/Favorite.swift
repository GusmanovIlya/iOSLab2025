import Foundation

struct Favorite: Identifiable, Codable {
    let id: UUID
    var title: String     
    var note: String
    
    init(id: UUID = UUID(), title: String, note: String = "") {
        self.id = id
        self.title = title
        self.note = note
    }
}

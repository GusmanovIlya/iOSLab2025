import SwiftUI
import Foundation
import Observation

@MainActor
@Observable
final class FavoritesViewModel {
    
    var favorites: [Favorite] = [] {
        didSet {
            storage.saveFavorites(favorites)
        }
    }
    
    var newTitle: String = ""
    var newNote: String = ""
    
    private let storage: FavoritesStorage
    
    init(storage: FavoritesStorage) {
        self.storage = storage
        loadFavorites()
    }
    
    private func loadFavorites() {
        let stored = storage.loadFavorites()
        self.favorites = stored
    }
    
    func addFavorite() {
        let trimmedTitle = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNote = newNote.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else { return }
        
        let item = Favorite(title: trimmedTitle, note: trimmedNote)
        
        favorites.append(item)
        
        newTitle = ""
        newNote = ""
    }
    
    func removeFavorites(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
    }
}

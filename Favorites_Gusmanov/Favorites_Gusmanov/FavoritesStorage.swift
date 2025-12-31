import Foundation

protocol FavoritesStorage {
    func loadFavorites() -> [Favorite]
    func saveFavorites(_ items: [Favorite])
}

final class UserDefaultsFavoritesStorage: FavoritesStorage {
    
    private let storageKey = "favorites_movies"
    
    private let defaults = UserDefaults.standard
    
    func loadFavorites() -> [Favorite] {
        guard let data = defaults.data(forKey: storageKey) else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let items = try decoder.decode([Favorite].self, from: data)
            return items
        } catch {
            print("Ошибка декодирования favorites:", error)
            return []
        }
    }
    
    func saveFavorites(_ items: [Favorite]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            defaults.set(data, forKey: storageKey)
        } catch {
            print("Ошибка кодирования favorites:", error)
        }
    }
}

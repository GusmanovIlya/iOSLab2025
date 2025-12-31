import Foundation
import Observation

@MainActor
@Observable
final class CryptoListViewModel {
    
    // данные для UI
    var items: [Crypto] = []
    var isLoading: Bool = false
    var error: String? = nil
    
    private let service: CryptoService
    
    init(service: CryptoService) {
        self.service = service
    }
    
    /// Загрузка данных
    func load() async {
        if isLoading { return }
        
        if !items.isEmpty && error == nil {
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            let cryptos = try await service.fetchCryptos()
            
            // сортировка
            let sorted = cryptos.sorted { $0.currentPrice > $1.currentPrice }
            self.items = sorted
        } catch {
            self.error = error.localizedDescription
            self.items = []
        }
        
        isLoading = false
    }
    
    func retry() async {
        await load()
    }
}

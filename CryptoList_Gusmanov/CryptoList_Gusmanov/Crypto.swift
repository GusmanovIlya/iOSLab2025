import Foundation

// Модель одной криптовалюты
struct Crypto: Identifiable, Codable {
    let id: String
    let name: String
    let symbol: String
    let currentPrice: Double
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case currentPrice = "current_price"
        case image
    }
}


extension Double {
    func formattedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: self))
        ?? String(format: "$%.2f", self)
    }
}

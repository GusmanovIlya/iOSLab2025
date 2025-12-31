import Foundation

struct Recipe: Identifiable, Hashable {
    let id: UUID
    let title: String
    let imageName: String
    let summary: String
    let category: String
    
    init(
        id: UUID = UUID(),
        title: String,
        imageName: String,
        summary: String,
        category: String
    ) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.summary = summary
        self.category = category
    }
}

extension Recipe {
    static let sampleRecipes: [Recipe] = [
        Recipe(
            title: "Паста карбонара",
            imageName: "fork.knife",
            summary: "Классическая паста с беконом и сливками.",
            category: "Итальянская"
        ),
        Recipe(
            title: "Салат Цезарь",
            imageName: "leaf",
            summary: "Салат с курицей, сухариками и сыром.",
            category: "Салаты"
        ),
        Recipe(
            title: "Том Ям",
            imageName: "flame",
            summary: "Острый тайский суп с креветками.",
            category: "Азиатская"
        )
    ]
}

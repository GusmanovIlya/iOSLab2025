import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe         
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                
                Image(systemName: recipe.imageName.isEmpty ? "photo" : recipe.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(20)
            }
            .frame(height: 100)

            Text(recipe.category)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(recipe.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(recipe.summary)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
        .contextMenu {
            Button(action: onDelete) {
                Label("Удалить", systemImage: "trash")
            }
        }
    }
}

#Preview {
    RecipeCardView(
        recipe: Recipe.sampleRecipes.first!,
        onDelete: {}
    )
    .padding()
    .previewLayout(.sizeThatFits)
}

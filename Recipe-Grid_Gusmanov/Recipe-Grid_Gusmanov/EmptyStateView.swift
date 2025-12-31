import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "text.magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.title3)
                .bold()
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(
        title: "Пока нет рецептов",
        message: "Нажмите «+», чтобы добавить первый рецепт."
    )
}

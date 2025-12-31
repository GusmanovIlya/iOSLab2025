import SwiftUI

struct ContentView: View {
    
    @State private var recipes: [Recipe] = Recipe.sampleRecipes
    
    @State private var searchText: String = ""
    
    @State private var isShowingAddSheet: Bool = false
    
    private let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    private var filteredRecipes: [Recipe] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if query.isEmpty {
            return recipes
        }
        
        return recipes.filter { recipe in
            recipe.title.lowercased().contains(query) ||
            recipe.category.lowercased().contains(query)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchBar
                
                if filteredRecipes.isEmpty {
                    Spacer()
                    if recipes.isEmpty {
                        EmptyStateView(
                            title: "Пока нет рецептов",
                            message: "Нажмите на кнопку «+» сверху, чтобы добавить первый рецепт."
                        )
                    } else {
                        EmptyStateView(
                            title: "Ничего не найдено",
                            message: "Измените запрос или добавьте новый рецепт."
                        )
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredRecipes) { recipe in
                                RecipeCardView(recipe: recipe) {
                                    delete(recipe)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Рецепты")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                AddRecipeSheet { newRecipe in
                    recipes.append(newRecipe)
                }
            }
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Поиск по названию или категории", text: $searchText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
        )
        .padding([.horizontal, .top])
    }
    
    private func delete(_ recipe: Recipe) {
        if let index = recipes.firstIndex(of: recipe) {
            recipes.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}

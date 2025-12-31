import SwiftUI

struct AddRecipeSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var imageName: String = ""
    @State private var summary: String = ""
    @State private var category: String = ""
    
    let onAdd: (Recipe) -> Void
    
    private var isTitleValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Основное")) {
                    TextField("Название *", text: $title)
                    TextField("Категория", text: $category)
                }
                
                Section(header: Text("Картинка")) {
                    TextField("Имя SF Symbol, например flame", text: $imageName)
                }
                
                Section(header: Text("Описание")) {
                    TextField("Краткое описание", text: $summary, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
                
                if !isTitleValid {
                    Section {
                        Text("Поле «Название» обязательно.")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("Новый рецепт")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        let newRecipe = Recipe(
                            title: title,
                            imageName: imageName,
                            summary: summary,
                            category: category
                        )
                        onAdd(newRecipe)
                        dismiss()
                    }
                    .disabled(!isTitleValid)
                }
            }
        }
    }
}

#Preview {
    AddRecipeSheet { recipe in
        print(recipe)
    }
}

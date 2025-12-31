import SwiftUI

struct NewMovieView: View {
    @Binding var movie: Movie
    
    let onSave: (Movie) -> Void
    
    let onCancel: () -> Void
    
    var body: some View {
        Form {
            Section("Основное") {
                TextField("Название", text: $movie.title)
                TextField("Жанр", text: $movie.genre)
                
                TextField("Год выхода", value: $movie.releaseYear, format: .number)
                    .keyboardType(.numberPad)
            }
            
            Section("Описание") {
                TextEditor(text: $movie.description)
                    .frame(minHeight: 150)
            }
        }
        .navigationTitle("Новый фильм")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Отмена") {
                    onCancel()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Сохранить") {
                    onSave(movie)
                }
                .disabled(movie.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewMovieView(
            movie: .constant(.empty),
            onSave: { _ in },
            onCancel: { }
        )
    }
}

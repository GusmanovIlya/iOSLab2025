import SwiftUI

struct MovieDetailView: View {
    @Binding var movie: Movie
    
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
        .navigationTitle(movie.title.isEmpty ? "Новый фильм" : movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: .constant(Movie.examples[0]))
    }
}

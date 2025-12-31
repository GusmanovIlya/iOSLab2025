import SwiftUI
import Observation

struct MoviesListView: View {
    @Bindable var store: MovieStore
    
    @State private var isPresentingNewMovie = false
    @State private var newMovie = Movie.empty
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($store.movies) { $movie in
                    NavigationLink {
                        MovieDetailView(movie: $movie)
                    } label: {
                        MovieRowView(movie: movie)
                    }
                }
                .onDelete { indexSet in
                    store.delete(at: indexSet)
                }
            }
            .navigationTitle("Фильмы")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newMovie = .empty
                        isPresentingNewMovie = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewMovie) {
                NavigationStack {
                    NewMovieView(
                        movie: $newMovie,
                        onSave: { movie in
                            store.add(movie)
                            isPresentingNewMovie = false
                        },
                        onCancel: {
                            isPresentingNewMovie = false
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    MoviesListView(store: MovieStore())
}

import Foundation
import Observation
import SwiftUI

@Observable
class MovieStore {
    
    var movies: [Movie]
    
    init(movies: [Movie] = Movie.examples) {
        self.movies = movies
    }
    
    func add(_ movie: Movie) {
        movies.append(movie)
    }
    
    func delete(at offsets: IndexSet) {
        movies.remove(atOffsets: offsets)
    }
}

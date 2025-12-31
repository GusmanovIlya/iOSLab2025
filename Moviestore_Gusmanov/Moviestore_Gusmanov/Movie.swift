import Foundation

struct Movie: Identifiable, Hashable {
    var id = UUID()
    
    var title: String
    
    var genre: String
    
    var description: String
    
    var releaseYear: Int
}

extension Movie {
    static let examples: [Movie] = [
        Movie(
            title: "The Matrix",
            genre: "Sci-Fi",
            description: "A hacker discovers reality is a simulation.",
            releaseYear: 1999
        ),
        Movie(
            title: "Inception",
            genre: "Sci-Fi",
            description: "A thief steals information via dreams.",
            releaseYear: 2010
        ),
        Movie(
            title: "Interstellar",
            genre: "Sci-Fi",
            description: "Exploring space to save humanity.",
            releaseYear: 2014
        )
    ]
    
    static let empty = Movie(
        title: "",
        genre: "",
        description: "",
        releaseYear: 2025
    )
}

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                
                Text(movie.genre)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("\(movie.releaseYear)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        MovieRowView(movie: Movie.examples[0])
        MovieRowView(movie: Movie.examples[1])
    }
}

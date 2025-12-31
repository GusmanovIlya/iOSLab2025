import SwiftUI

@main
struct Moviestore_GusmanovApp: App {
    @State private var store = MovieStore()
    var body: some Scene {
        WindowGroup {
            MoviesListView(store: store)
        }
    }
}

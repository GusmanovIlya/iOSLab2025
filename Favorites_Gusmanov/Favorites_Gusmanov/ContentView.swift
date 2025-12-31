import SwiftUI
import Observation

struct ContentView: View {
    
    @State private var viewModel = FavoritesViewModel(
        storage: UserDefaultsFavoritesStorage()
    )
    
    var body: some View {
        NavigationStack {
            FavoritesScreen(viewModel: viewModel)
                .navigationTitle("Избранные фильмы")
        }
    }
}

#Preview {
    ContentView()
}

struct FavoritesScreen: View {
    
    @Bindable var viewModel: FavoritesViewModel
    
    var body: some View {
        VStack {
            NewFavoriteForm(
                title: $viewModel.newTitle,
                note: $viewModel.newNote,
                onAdd: viewModel.addFavorite
            )
            .padding()
            
            Divider()
            
            FavoritesList(
                items: viewModel.favorites,
                onDelete: viewModel.removeFavorites(at:)
            )
        }
    }
}

struct NewFavoriteForm: View {
    
    @Binding var title: String
    @Binding var note: String
    let onAdd: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Добавить фильм")
                .font(.headline)
            
            TextField("Название фильма", text: $title)
                .textFieldStyle(.roundedBorder)
            
            TextField("Заметка (необязательно)", text: $note)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Spacer()
                Button {
                    onAdd()
                } label: {
                    Text("Добавить")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

struct FavoritesList: View {
    
    let items: [Favorite]
    let onDelete: (IndexSet) -> Void
    
    var body: some View {
        if items.isEmpty {
            VStack(spacing: 8) {
                Text("Список пуст")
                    .font(.headline)
                Text("Добавьте первый фильм через форму выше.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(items) { item in
                    FavoriteRowView(item: item)
                }
                .onDelete(perform: onDelete)
            }
            .listStyle(.plain)
        }
    }
}

struct FavoriteRowView: View {
    
    let item: Favorite
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.headline)
            
            if !item.note.isEmpty {
                Text(item.note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

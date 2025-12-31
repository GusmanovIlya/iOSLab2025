import SwiftUI
import Observation

struct ContentView: View {
    
    @State private var viewModel = WeatherViewModel(service: RealWeatherService())
    
    var body: some View {
        NavigationStack {
            CityWeatherScreen(viewModel: viewModel)
                .navigationTitle("Weather Cities")
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    ContentView()
}

struct CityWeatherScreen: View {
    
    @Bindable var viewModel: WeatherViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let errorMessage = viewModel.error {
                errorView(message: errorMessage)
            } else {
                CityWeatherListView(items: viewModel.items)
            }
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Загружаем погоду...")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Text("Произошла ошибка")
                .font(.headline)
            Text(message)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Button {
                Task {
                    await viewModel.retry()
                }
            } label: {
                Text("Повторить")
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CityWeatherListView: View {
    
    let items: [CityWeather]
    
    var body: some View {
        List(items) { item in
            CityWeatherRowView(item: item)
        }
    }
}

struct CityWeatherRowView: View {
    
    let item: CityWeather
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.city.name)
                    .font(.headline)
                
                Text("Ветер: \(Int(item.windSpeed)) км/ч")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(String(format: "%.1f ℃", item.temperature))
                .font(.title3)
                .bold()
        }
        .padding(.vertical, 4)
    }
}

import Foundation
import Observation

@MainActor
@Observable
final class WeatherViewModel {
    
    let cities: [City] = [
        City(name: "Москва",      latitude: 55.7558, longitude: 37.6173),
        City(name: "Санкт-Петербург", latitude: 59.9343, longitude: 30.3351),
        City(name: "Лондон",      latitude: 51.5074, longitude: -0.1278),
        City(name: "Нью-Йорк",    latitude: 40.7128, longitude: -74.0060),
        City(name: "Токио",       latitude: 35.6762, longitude: 139.6503)
    ]
    
    var items: [CityWeather] = []
    
    var isLoading: Bool = false
    
    var error: String? = nil
    
    private let service: WeatherService
    
    init(service: WeatherService) {
        self.service = service
    }
    
    func load() async {
        if isLoading { return }
        
        isLoading = true
        error = nil
        items = []
        
        do {
            var results: [CityWeather] = []
            
            try await withThrowingTaskGroup(of: CityWeather.self) { group in
                for city in cities {
                    group.addTask {
                        try await self.service.fetchWeather(for: city)
                    }
                }
                
                for try await cityWeather in group {
                    results.append(cityWeather)
                }
            }
            
            self.items = results
            
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func retry() async {
        await load()
    }
}

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchWeather(for location: String = "auto:ip") {
        isLoading = true
        errorMessage = nil
        
        WeatherService.shared.fetchWeather(location: location) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let weatherResponse):
                    self?.weatherData = weatherResponse
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Weather fetch error: \(error.localizedDescription)")
                }
            }
        }
    }
}

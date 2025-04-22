import Foundation

class WeatherService {
    static let shared = WeatherService()
    
    private init() {}
    
    func fetchWeather(location: String = "auto:ip", completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let endpoint = "/forecast.json?q=\(location)&days=1&aqi=no&alerts=no"
        let urlString = WeatherAPIConfig.baseURL + endpoint
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue(WeatherAPIConfig.apiKey, forHTTPHeaderField: "key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

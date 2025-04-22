import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
}

struct CurrentWeather: Codable {
    let tempC: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
    let astro: Astro
}

struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
    }
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    
    // Format the times to remove AM/PM if needed
    func formattedSunrise() -> String {
        return sunrise.replacingOccurrences(of: " AM", with: "").replacingOccurrences(of: " PM", with: "")
    }
    
    func formattedSunset() -> String {
        return sunset.replacingOccurrences(of: " AM", with: "").replacingOccurrences(of: " PM", with: "")
    }
}

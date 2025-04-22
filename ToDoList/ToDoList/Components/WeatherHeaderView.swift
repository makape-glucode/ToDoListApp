import SwiftUI

struct WeatherHeaderView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if weatherVM.isLoading {
                ProgressView()
            } else if let weather = weatherVM.weatherData {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(weather.location.name)
                            .font(.headline)
                        
                        Text("\(weather.current.tempC, specifier: "%.0f")°C | \(weather.current.condition.text)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        HStack {
                            Image(systemName: "sunrise")
                            Text(weather.forecast.forecastday[0].astro.sunrise)
                        }
                        
                        HStack {
                            Image(systemName: "sunset")
                            Text(weather.forecast.forecastday[0].astro.sunset)
                        }
                    }
                    .font(.subheadline)
                }
            } else {
                Text("Weather data unavailable")
            }
        }
        .padding()
    }
}

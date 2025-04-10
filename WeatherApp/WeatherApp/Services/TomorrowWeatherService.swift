







import Foundation

protocol TomorrowWeatherServiceProtocol {
    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> WeatherData
    func fetchForecast(lat: Double, lon: Double) async throws -> [HourlyWeatherData]
}

class TomorrowWeatherService: TomorrowWeatherServiceProtocol {
    private let apiKey = "yduR14lS3WKBDsxqdmLHUAbIAHKxWV6L" // Ваш API-ключ
    private let baseURL = "https://api.tomorrow.io/v4/weather/forecast"

    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> WeatherData {
        let url = try buildURL(lat: lat, lon: lon)
        let (data, _) = try await URLSession.shared.data(from: url)

        let decodedResponse = try JSONDecoder().decode(TomorrowWeatherResponse.self, from: data)
        guard let currentWeather = decodedResponse.timelines.hourly.first else {
            throw URLError(.badServerResponse)
        }

        return WeatherData(
            temperature: currentWeather.values.temperature,
            description: "Cloud Cover: \(currentWeather.values.cloudCover)%",
            time: currentWeather.time
        )
    }

    func fetchForecast(lat: Double, lon: Double) async throws -> [HourlyWeatherData] {
        let url = try buildURL(lat: lat, lon: lon)
        let (data, _) = try await URLSession.shared.data(from: url)

        let decodedResponse = try JSONDecoder().decode(TomorrowWeatherResponse.self, from: data)
        return decodedResponse.timelines.hourly.map {
            HourlyWeatherData(
                time: $0.time,
                temperature: $0.values.temperature,
                humidity: $0.values.humidity
            )
        }
    }

    private func buildURL(lat: Double, lon: Double) throws -> URL {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "location", value: "\(lat),\(lon)"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return url
    }
}

// Вспомогательные структуры для декодирования ответа API
private struct TomorrowWeatherResponse: Decodable {
    let timelines: Timelines

    struct Timelines: Decodable {
        let hourly: [HourlyData]
    }

    struct HourlyData: Decodable {
        let time: String
        let values: HourlyValues
    }

    struct HourlyValues: Decodable {
        let temperature: Double
        let humidity: Double
        let cloudCover: Double
    }
}

// Модели данных
struct WeatherData {
    let temperature: Double
    let description: String
    let time: String
}

struct HourlyWeatherData {
    let time: String
    let temperature: Double
    let humidity: Double
}

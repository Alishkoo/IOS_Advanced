//
//  TomorrowWeatherViewModel.swift
//  WeatherApp
//
//  Created by Alibek Baisholanov on 10.04.2025.
//
import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: WeatherData?
    @Published var forecast: [HourlyWeatherData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService: TomorrowWeatherServiceProtocol

    init(weatherService: TomorrowWeatherServiceProtocol = TomorrowWeatherService()) {
        self.weatherService = weatherService
    }

    func fetchAllWeatherData(lat: Double, lon: Double) async {
        isLoading = true
        errorMessage = nil

        do {
            try await withTaskGroup(of: Void.self) { group in
                // Загрузка текущей погоды
                group.addTask {
                    do {
                        let currentWeather = try await self.weatherService.fetchCurrentWeather(lat: lat, lon: lon)
                        await MainActor.run {
                            self.currentWeather = currentWeather
                        }
                    } catch {
                        print("Ошибка загрузки текущей погоды: \(error.localizedDescription)")
                    }
                }

                // Загрузка прогноза погоды
                group.addTask {
                    do {
                        let forecast = try await self.weatherService.fetchForecast(lat: lat, lon: lon)
                        await MainActor.run {
                            self.forecast = forecast
                        }
                    } catch {
                        print("Ошибка загрузки прогноза погоды: \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            errorMessage = "Ошибка загрузки данных: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

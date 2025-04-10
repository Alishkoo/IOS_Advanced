//
//  ContentView.swift
//  WeatherApp
//
//  Created by Alibek Baisholanov on 10.04.2025.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView("Загрузка данных...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else {
                if let currentWeather = viewModel.currentWeather {
                    VStack(alignment: .leading) {
                        Text("Текущая погода")
                            .font(.headline)
                        Text("Температура: \(currentWeather.temperature, specifier: "%.1f")°C")
                        Text("Описание: \(currentWeather.description)")
                        Text("Время: \(currentWeather.time)")
                    }
                    .padding()
                }

                if !viewModel.forecast.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Прогноз на несколько часов")
                            .font(.headline)
                        ForEach(viewModel.forecast, id: \.time) { weather in
                            Text("Время: \(weather.time), Температура: \(weather.temperature, specifier: "%.1f")°C, Влажность: \(weather.humidity, specifier: "%.0f")%")
                        }
                    }
                    .padding()
                }
            }

            Button("Обновить данные") {
                Task {
                    await viewModel.fetchAllWeatherData(lat: 42.3478, lon: -71.0466) // Пример координат
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ContentView()
}

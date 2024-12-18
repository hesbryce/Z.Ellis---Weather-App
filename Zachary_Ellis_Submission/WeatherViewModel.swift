//
//  WeatherViewModel.swift
//  Zachary_Ellis_Submission
//
//  Created by Bryce Ellis on 12/18/24.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var isSearching: Bool = false // This must exist
    @Published var weather: Weather?
    @Published var searchResult: Weather?
    @Published var errorMessage: String?

    private let service: WeatherServiceProtocol

    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func fetchWeather(for city: String) {
        self.isSearching = true
            self.errorMessage = nil
    
            service.fetchWeather(for: city) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isSearching = false
                    switch result {
                    case .success(let weather):
                        self?.weather = weather
                    case .failure(let error):
                        self?.errorMessage = "Failed to load weather for \(city). Error: \(error.localizedDescription)"
                    }
                }
            }
        }
    
    func confirmSearchResult() {
            if let result = searchResult {
                self.weather = result
                self.saveCity(result.location.name)
                self.searchResult = nil
            }
        }
    
        private func saveCity(_ city: String) {
            UserDefaults.standard.setValue(city, forKey: "savedCity")
        }
    
        func loadSavedCity() {
            if let savedCity = UserDefaults.standard.string(forKey: "savedCity") {
                fetchWeather(for: savedCity)
            }
        }
        
    func searchWeather(for city: String) {
        self.isSearching = true
        self.errorMessage = nil

        service.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isSearching = false
                switch result {
                case .success(let weather):
                    self?.searchResult = weather
                case .failure(let error):
                    self?.errorMessage = "No results for \(city). Try again."
                }
            }
        }
    }
}


//import SwiftUI
//
//class WeatherViewModel: ObservableObject {
//    @Published var weather: Weather?
//    @Published var searchResult: Weather?
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
//
//    private let service: WeatherServiceProtocol
//
//    init(service: WeatherServiceProtocol = WeatherService()) {
//        self.service = service
//    }
//
//    func fetchWeather(for city: String) {
//        self.isLoading = true
//        self.errorMessage = nil
//
//        service.fetchWeather(for: city) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                switch result {
//                case .success(let weather):
//                    self?.weather = weather
//                case .failure(let error):
//                    self?.errorMessage = "Failed to load weather for \(city). Error: \(error.localizedDescription)"
//                }
//            }
//        }
//    }
//
//    func searchWeather(for city: String) {
//        self.isLoading = true
//        self.errorMessage = nil
//
//        service.fetchWeather(for: city) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                switch result {
//                case .success(let weather):
//                    self?.searchResult = weather
//                case .failure(let error):
//                    self?.errorMessage = "No results for \(city). Try again."
//                }
//            }
//        }
//    }
//    
//    func confirmSearchResult() {
//        if let result = searchResult {
//            self.weather = result
//            self.saveCity(result.location.name)
//            self.searchResult = nil
//        }
//    }
//
//    private func saveCity(_ city: String) {
//        UserDefaults.standard.setValue(city, forKey: "savedCity")
//    }
//
//    func loadSavedCity() {
//        if let savedCity = UserDefaults.standard.string(forKey: "savedCity") {
//            fetchWeather(for: savedCity)
//        }
//    }
//
//}

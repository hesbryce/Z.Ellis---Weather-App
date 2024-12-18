//
//  WeatherServiceProtocol.swift
//  Zachary_Ellis_Submission
//
//  Created by Bryce Ellis on 12/18/24.
//


import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        let urlString = "\(APIConstants.baseURL)?key=\(APIConstants.apiKey)&q=\(city)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

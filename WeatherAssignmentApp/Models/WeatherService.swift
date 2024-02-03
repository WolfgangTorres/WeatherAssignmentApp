//
//  WeatherService.swift
//  WeatherAssignmentApp
//
// Provides networking functionality to fetch weather data from
// a remote service.
//
//  Created by Andres Torres on 03/02/24.
//

import Foundation

/// Singleton Service Class responsible for fetching weather data from Open-Meteo API
class WeatherService {
    
    /// Shared instance of the WeatherService for use throughout the app
    static let shared = WeatherService()
    
    /// The base url for the Open-Meteo API
    private let baseUrl = URL(string: "https://api.open-meteo.com/v1/forecast")!
    
    /**
     Decodes JSON data into a specified Decodable type,
     using generic types to be reusable for any Decodable type
     
     - Parameters:
        - type: Type conforming to Decodable, to decode the data into
        - data: JSON data to decode
     - Throws: Error if decoding fails
     - Returns: Instance of the specified type filled with the decoded data
     */
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
    
    /**
     Fetches data from a URL and decode it into the specified decodable type,
     using generics to fetch any type of decodable data
     
     - Parameters:
        - url: URL to fetch data from
     - Throws: Error if the network request fails or if the HTTP response is not 200
     - Returns: Instance of the specified type with the data fetched from the URL
     */
    private func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse =
                response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try decodeJSON(type: T.self, from: data)
        
        return decodedData
    }
    
    /**
     Fetches weather data for a specific latitude and longitude with an option to get the current weather data
     
     - Parameters:
        - latitude: Latitude for which to fetch weather data
        - longitude: Longitude for which to fetch weather data
        - currentWeather: Bool value indication whether to fetch current weather data
     - Throws: Error if the network request fails or if the URL is invalid
     - Returns: Weather object containing the weather data for the specified location
     */
    func fetchWeatherData(
        latitude: Double = 52.52,
        longitude: Double = 13.41,
        currentWeather: Bool = true
    ) async throws -> WeatherData {
        
        var components = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: true)
        
        // Prepare query params with the default or provided arguments
        components?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "current_weather", value: currentWeather ? "true" : "false")
        ]
        
        // Construct the full URL
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        // Fetch and decode the weather data
        return try await fetchData(from: url)
    }
}

//
//  WeatherData.swift
//  WeatherAssignmentApp
//
// Defines the data structures for the weather information
//
//  Created by Andres Torres on 03/02/24.
//

import Foundation

/**
 The `WeatherData` is designed to parse the JSON response from the API
 It includes latitude, longitude and the current weather conditions.
 */
struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currentWeather: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case currentWeather = "current_weather"
    }
    
    struct CurrentWeather: Codable {
        let time: String
        let temperature: Double
        let windspeed: Double
        let winddirection: Int
        let isDay: Int
        let weathercode: Int
        
        enum CodingKeys: String, CodingKey {
            case time, temperature, windspeed, winddirection, weathercode
            case isDay = "is_day"
        }
    }
}

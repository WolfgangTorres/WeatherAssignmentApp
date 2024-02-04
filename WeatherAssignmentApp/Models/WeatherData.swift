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
    let generationtimeMs: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    let currentWeatherUnits: CurrentWeatherUnits
    let currentWeather: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMs = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeatherUnits = "current_weather_units"
        case currentWeather = "current_weather"
    }
    
    struct CurrentWeatherUnits: Codable {
        let time: String
        let temperature: String
        let windspeed: String
        let winddirection: String
        let isDay: String
        let weathercode: String
        
        enum CodingKeys: String, CodingKey {
            case time, temperature, windspeed, winddirection, weathercode
            case isDay = "is_day"
        }
    }

    struct CurrentWeather: Codable {
        let time: String
        let interval: Int
        let temperature: Double
        let windspeed: Double
        let winddirection: Int
        let isDay: Int
        let weathercode: Int
        
        enum CodingKeys: String, CodingKey {
            case time, interval, temperature, windspeed, winddirection, weathercode
            case isDay = "is_day"
        }
    }
}

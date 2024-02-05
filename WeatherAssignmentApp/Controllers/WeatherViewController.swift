//
//  WeatherViewController.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import UIKit

// The WeatherViewController is responsible for
// managing the view that displays weather information.
class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // Stack view that contains all the weather-related views.
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lastUpdateView: WeatherReusableView!
    @IBOutlet weak var windView: WeatherReusableView!
    @IBOutlet weak var temperatureView: WeatherReusableView!
    
    // MARK: - Properties
    
    // The weatherInfo property holds the latest weather data.
    // When set, it updates the UI.
    var weatherInfo: WeatherData? {
        didSet {
            self.configureViews()
        }
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially hide the stack container and
        // show the activity indicator until data is fetched.
        self.stackContainer.isHidden = true
        self.fetchWeatherData()
    }
    
    // MARK: - Functions
    
    // fetchWeatherData calls the WeatherService to retrieve weather data asynchronously.
    private func fetchWeatherData() {
        Task {
            do {
                // Attempt to fetch the weather data.
                let weatherData = try await WeatherService.shared.fetchWeatherData()
                
                // If successful, store the result in
                // weatherInfo which triggers the UI update.
                self.weatherInfo = weatherData
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    // configureViews updates each WeatherReusableView with the appropriate data.
    private func configureViews() {
        guard let weather = self.weatherInfo else { return }
        
        // Configure each view with its respective title and value.
        self.temperatureView.configure(
            title: "temperature".localized(),
            value: "\(weather.currentWeather.temperature)\(weather.currentWeatherUnits.temperature)")
        
        self.windView.configure(
            title: "wind".localized(),
            value: "\(weather.currentWeather.windspeed) \(weather.currentWeatherUnits.windspeed)")
        
        self.lastUpdateView.configure(
            title: "lastUpdated".localized(),
            value: weather.currentWeather.time.convertDateFormat(
                to: "hh:mm a, MMMM dd, yyyy"
            )
        )
        
        // Stop the activity indicator and reveal
        // the stack container with the weather data.
        self.activityIndicator.stopAnimating()
        self.stackContainer.isHidden = false
    }
    
    
}


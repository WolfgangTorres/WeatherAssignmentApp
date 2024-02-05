//
//  WeatherViewController.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lastUpdateView: WeatherReusableView!
    @IBOutlet weak var windView: WeatherReusableView!
    @IBOutlet weak var temperatureView: WeatherReusableView!
    
    var weatherInfo: WeatherData? {
        didSet {
            self.configureViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stackContainer.isHidden = true
        self.fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        Task {
            do {
                let weatherData = try await WeatherService.shared.fetchWeatherData()
                
                self.weatherInfo = weatherData
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func configureViews() {
        guard let weather = self.weatherInfo else { return }
        
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
        
        self.activityIndicator.stopAnimating()
        self.stackContainer.isHidden = false
    }


}


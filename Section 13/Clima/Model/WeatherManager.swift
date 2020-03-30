//
//  WeatherManager.swift
//  Clima
//
//  Created by Drew Dodson on 3/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherAPIURL = "https://api.openweathermap.org/data/2.5/weather?appid=89d1adb22cba3371ca075d26693aa030&units=imperial"
    var delegate: WeatherManagerDelegate?


    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherAPIURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherAPIURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
}

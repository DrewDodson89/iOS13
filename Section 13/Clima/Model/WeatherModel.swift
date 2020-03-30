//
//  WeatherModel.swift
//  Clima
//
//  Created by Drew Dodson on 3/28/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var conditonName: String {
        switch conditionID {
        case 1:
            return ""
        case 200...299:
            //Thunderstorms
            return "cloud.bolt.rain"
        case 300...399:
            //Drizzle
            return "cloud.drizzle"
        case 400...499:
            //Error
            return "Error"
        case 500...599:
            //Rain
            return "cloud.rain"
        case 600...699:
            //Snow
            return "cloud.snow"
        case 700...799:
            //Atmostphere
            return "cloud.fog"
        case 800:
            //Clear
            return "sun.max"
        case 801...804:
            //Cloud
            return "cloud"
        default:
            return "Error"
        }
    }
}

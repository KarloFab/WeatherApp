//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Karlo Fabijanić on 25.11.2021..
//

import Foundation

struct WeatherManager {
    let weatherUrl = ""
    
    func fetchWeather(cityName: String){
        let weatherUrl = "\(weatherUrl)&q=\(cityName)"
    }
}

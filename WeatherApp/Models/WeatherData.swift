//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Karlo Fabijanić on 26.11.2021..
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}

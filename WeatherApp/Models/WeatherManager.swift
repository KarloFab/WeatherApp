//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Karlo Fabijanić on 25.11.2021..
//

import Foundation

struct WeatherManager {
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?appid=936bf8f061470e716592ccabe03bde8b&units=metric"
    
    func fetchWeather(cityName: String){
        let weatherUrl = "\(apiUrl)&q=\(cityName)"
        performRequest(urlString: weatherUrl)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}

//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Karlo Fabijanić on 25.11.2021..
//

import Foundation
import CoreLocation

protocol WeatherManagerDelagate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?appid=&units=metric"
    
    var delegate: WeatherManagerDelagate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(apiUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherByCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(apiUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

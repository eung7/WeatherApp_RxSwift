//
//  WeatherResult.swift
//  WeatherApp_RxSwift
//
//  Created by 김응철 on 2022/06/16.
//

import Foundation

struct WeatherResult: Decodable{
    let main: Weather
}

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}

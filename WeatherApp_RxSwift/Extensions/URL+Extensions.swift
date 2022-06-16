//
//  URL+Extensions.swift
//  WeatherApp_RxSwift
//
//  Created by 김응철 on 2022/06/16.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=2f94734b59ed393c884ba97fae88e446")
    }
}

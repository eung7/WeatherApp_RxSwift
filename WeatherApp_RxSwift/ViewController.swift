//
//  ViewController.swift
//  WeatherApp_RxSwift
//
//  Created by 김응철 on 2022/06/16.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
        let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResult>(url: url)
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.empty)
            .subscribe(onNext: { result in
                let weather = result.main
                self.displayWeather(weather)
            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            temperatureLabel.text = "\(weather.temp) ℉"
            humidityLabel.text = "\(weather.humidity) "
        } else {
            temperatureLabel.text = "👕"
            humidityLabel.text = "👖"
        }
    }
}

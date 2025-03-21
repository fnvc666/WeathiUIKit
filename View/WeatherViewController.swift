//
//  WeatherViewController.swift
//  Weathi
//
//  Created by on 09/03/2025.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Variables
    
    var onChangeColor: ((UIColor) -> Void)?
    var timezoneOffsetConst: Int?
    private let viewModel = WeatherViewModel()
    private let statusID: Int = 0
    
    // MARK: - UI Components
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunScreen")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let happyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Have a happy"
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Day"
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 200)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 1.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let windImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "wind"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.textAlignment = .center
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windValueLabel: UILabel = {
        let label = UILabel()
        label.text = "4 m/s"
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let precipitationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "cloud.drizzle"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let precipitationLabel: UILabel = {
        let label = UILabel()
        label.text = "Precipitation"
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let precipitationValueLabel: UILabel = {
        let label = UILabel()
        label.text = "5 %"
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "drop"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "Humidity"
        label.textAlignment = .center
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityValueLabel: UILabel = {
        let label = UILabel()
        label.text = "35 %"
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Medium", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorLineViewBotton: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 1.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNotification()
        setupUI()
        bindWeatherData()
    }
    
    // MARK: - Setup UI Methods
    
    private func setupUI() {
        view.alpha = 0
        view.addSubview(weatherImageView)
        view.addSubview(happyLabel)
        view.addSubview(weatherLabel)
        view.addSubview(dayLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(timeLabel)
        view.addSubview(cityLabel)
        view.addSubview(separatorLineView)
        view.addSubview(windImageView)
        view.addSubview(windLabel)
        view.addSubview(windValueLabel)
        view.addSubview(precipitationImageView)
        view.addSubview(precipitationLabel)
        view.addSubview(precipitationValueLabel)
        view.addSubview(humidityImageView)
        view.addSubview(humidityLabel)
        view.addSubview(humidityValueLabel)
        view.addSubview(separatorLineViewBotton)
        setupConstraints()
    }
    
    private func setTheme(status: Int) {
        
        let labels = [
            happyLabel, dayLabel, weatherLabel, temperatureLabel, timeLabel,
            cityLabel, windLabel, windValueLabel, precipitationLabel,
            precipitationValueLabel, humidityLabel, humidityValueLabel
        ]
        print("stst: \(status)")
        switch status{
            case 701...800:
                let newColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
                view.backgroundColor = newColor
                weatherImageView.image = UIImage(named: "sunScreen")
                labels.forEach{ label in
                    label.textColor = .black
                }
                onChangeColor?(newColor)
                
            case 801...804:
                let newColor = UIColor(red: 0.576, green: 0.682, blue: 0.643, alpha: 1)
                view.backgroundColor = newColor
                weatherImageView.image = UIImage(named: "cloudScreen")
                labels.forEach{ label in
                    label.textColor = .black
                }
                onChangeColor?(newColor)
                
            case 200...781:
                let newColor = UIColor(red: 0.192, green: 0.353, blue: 0.573, alpha: 1)
                view.backgroundColor = newColor
                weatherImageView.image = UIImage(named: "rainScreen")
                
                labels.forEach{ label in
                    label.textColor = .white
                }
                onChangeColor?(newColor)
                
            default:
                print("Default")
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 201),
            weatherImageView.widthAnchor.constraint(equalToConstant: 200),
            weatherImageView.heightAnchor.constraint(equalToConstant: 200),
            
            happyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 174),
            happyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            happyLabel.widthAnchor.constraint(equalToConstant: 100),
            happyLabel.heightAnchor.constraint(equalToConstant: 15),
            
            weatherLabel.topAnchor.constraint(equalTo: happyLabel.bottomAnchor, constant: 5),
            weatherLabel.leadingAnchor.constraint(equalTo: happyLabel.leadingAnchor),
            weatherLabel.heightAnchor.constraint(equalToConstant: 35),
            
            dayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 207),
            dayLabel.leadingAnchor.constraint(equalTo: weatherLabel.trailingAnchor, constant: 5),
            dayLabel.widthAnchor.constraint(equalToConstant: 30),
            dayLabel.heightAnchor.constraint(equalToConstant: 17),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 37),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 174),
            
            timeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 40),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            timeLabel.heightAnchor.constraint(equalToConstant: 26),
            timeLabel.widthAnchor.constraint(equalToConstant: 107),
            
            cityLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 21),
            cityLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: 23),
            
            separatorLineView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 25),
            separatorLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separatorLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separatorLineView.heightAnchor.constraint(equalToConstant: 3),
            
            windImageView.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: 18),
            windImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            windImageView.widthAnchor.constraint(equalToConstant: 25),
            windImageView.heightAnchor.constraint(equalToConstant: 25),
            
            windLabel.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
            windLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 6),
            windLabel.widthAnchor.constraint(equalToConstant: 38),
            windLabel.heightAnchor.constraint(equalToConstant: 25),
            
            windValueLabel.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windValueLabel.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: 144),
            windValueLabel.widthAnchor.constraint(equalToConstant: 47),
            windValueLabel.heightAnchor.constraint(equalToConstant: 25),
            
            precipitationImageView.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 14),
            precipitationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            precipitationImageView.widthAnchor.constraint(equalToConstant: 25),
            precipitationImageView.heightAnchor.constraint(equalToConstant: 25),
            
            precipitationLabel.centerYAnchor.constraint(equalTo: precipitationImageView.centerYAnchor),
            precipitationLabel.leadingAnchor.constraint(equalTo: precipitationImageView.trailingAnchor, constant: 6),
            precipitationLabel.heightAnchor.constraint(equalToConstant: 94),
            precipitationLabel.heightAnchor.constraint(equalToConstant: 25),
            
            precipitationValueLabel.centerYAnchor.constraint(equalTo: precipitationLabel.centerYAnchor),
            precipitationValueLabel.leadingAnchor.constraint(equalTo: precipitationLabel.trailingAnchor, constant: 88),
            precipitationValueLabel.widthAnchor.constraint(equalToConstant: 47),
            precipitationValueLabel.heightAnchor.constraint(equalToConstant: 25),
            
            humidityImageView.topAnchor.constraint(equalTo: precipitationImageView.bottomAnchor, constant: 14),
            humidityImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            humidityImageView.widthAnchor.constraint(equalToConstant: 25),
            humidityImageView.heightAnchor.constraint(equalToConstant: 30),
            
            humidityLabel.centerYAnchor.constraint(equalTo: humidityImageView.centerYAnchor),
            humidityLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 6),
            humidityLabel.widthAnchor.constraint(equalToConstant: 72),
            humidityLabel.heightAnchor.constraint(equalToConstant: 25),
            
            humidityValueLabel.centerYAnchor.constraint(equalTo: humidityLabel.centerYAnchor),
            humidityValueLabel.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 110),
            humidityValueLabel.widthAnchor.constraint(equalToConstant: 47),
            humidityValueLabel.heightAnchor.constraint(equalToConstant: 25),
            
            separatorLineViewBotton.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            separatorLineViewBotton.leadingAnchor.constraint(equalTo: separatorLineView.leadingAnchor),
            separatorLineViewBotton.trailingAnchor.constraint(equalTo: separatorLineView.trailingAnchor),
            separatorLineViewBotton.heightAnchor.constraint(equalToConstant: 3),
        ])
    }
    
    // MARK: - API Methods
    
    private func bindWeatherData() {
        viewModel.weatherData.bind { [weak self] data in
            guard let data = data else { return }
            
            self?.timezoneOffsetConst = data.timezone
            UserDefaults.standard.set(data.timezone, forKey: "timezoneOffset")
            
            self?.cityLabel.text = data.name
            self?.timeLabel.text = self?.formatTime(timestamp: data.dt, timezoneOffset: data.timezone)
            self?.temperatureLabel.text = "\(Int(data.main.temp))°"
            self?.weatherLabel.text = data.weather.first?.description.capitalized ?? "No data"
            self?.windValueLabel.text = "\(Int(data.wind?.speed ?? 0)) m/s"
            self?.humidityValueLabel.text = "\(Int(data.main.humidity))%"
            self?.precipitationValueLabel.text = "\(Int(data.rain?.lastHour ?? 0)) mm"
            self?.setTheme(status: data.weather.first?.id ?? 0)
            
            UIView.animate(withDuration: 0.3) {
                self?.view.alpha = 1
            }
        }
        if let cityName = UserDefaults.standard.string(forKey: "lastSelectedCity") {
            viewModel.loadWeather(for: cityName)
        } else {
            viewModel.loadWeather(for: "London")
        }
    }
    
    private func formatTime(timestamp: TimeInterval, timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: timestamp + TimeInterval(timezoneOffset))
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
    
    // MARK: - Notification Methods
    
    private func setNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cityDidChange(_:)),
            name: Notification.Name("cityDidChange"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(unitsDidChange(_:)),
            name: Notification.Name("unitsDidChange"),
            object: nil
            )
    }
    
    @objc private func cityDidChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let cityName = userInfo["cityName"] as? String
        else { return }
        
        viewModel.loadWeather(for: cityName)
    }
    
    @objc private func unitsDidChange(_ notifaction: Notification) {
        let cityName = UserDefaults.standard.string(forKey: "lastSelectedCity") ?? "London"
        viewModel.loadWeather(for: cityName)
    }
    
}

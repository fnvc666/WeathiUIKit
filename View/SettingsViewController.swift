//
//  SettingsViewController.swift
//  Weathi
//
//  Created by on 09/03/2025.
//

import UIKit

class SettingsViewController: UIViewController, UISearchResultsUpdating {
    
    // MARK: - Variables
    
    var searchController: UISearchController!
    var viewModel = SettingsViewModel()
    
    // MARK: - UI Components
    
    private let currentLocationlabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.layer.cornerRadius = 24
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "location"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationTitleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let measurementLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.layer.cornerRadius = 24
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let measurmentIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "thermometer.low"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let measurmentTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "Measurement Units"
        title.textColor = .black
        title.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 15)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let celsiusText: UILabel = {
        let title = UILabel()
        title.text = "°C"
        title.textColor = .black
        title.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let fahrenheitText: UILabel = {
        let title = UILabel()
        title.text = "°F"
        title.textColor = .black
        title.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = UserDefaults.standard.bool(forKey: "isMetric")
        switcher.onTintColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    private let appResetLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.layer.cornerRadius = 24
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let appResetIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "archivebox.fill"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let appResetTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "App Reset"
        title.textColor = .black
        title.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 15)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let appResetImageButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.trianglehead.2.counterclockwise"))
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.importCitiesIfNeeded()
        setupUI()
        bindHistoryData()
        setTargets()
    }
    
    // MARK: - Set UI Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
        
        view.addSubview(currentLocationlabel)
        view.addSubview(measurementLabel)
        view.addSubview(appResetLabel)
        
        currentLocationlabel.addSubview(locationImageView)
        currentLocationlabel.addSubview(locationTitleLabel)
        
        measurementLabel.addSubview(measurmentIcon)
        measurementLabel.addSubview(measurmentTitleLabel)
        measurementLabel.addSubview(celsiusText)
        measurementLabel.addSubview(switcher)
        measurementLabel.addSubview(fahrenheitText)
        
        appResetLabel.addSubview(appResetIcon)
        appResetLabel.addSubview(appResetTitleLabel)
        appResetLabel.addSubview(appResetImageButton)
        
        setupConstraints()
        setupSearchController()
    }
    
    private func styleSearchBar() {
        let searchBar = searchController.searchBar
        
        searchBar.backgroundImage = UIImage()
        searchBar.searchBarStyle = .minimal
        
        if #available(iOS 13.0, *) {
            let textField = searchBar.searchTextField
            textField.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.25)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            currentLocationlabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            currentLocationlabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            currentLocationlabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            currentLocationlabel.heightAnchor.constraint(equalToConstant: 75),
            
            locationImageView.centerYAnchor.constraint(equalTo: currentLocationlabel.centerYAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: currentLocationlabel.leadingAnchor, constant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationTitleLabel.centerYAnchor.constraint(equalTo: currentLocationlabel.centerYAnchor),
            locationTitleLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 14),
            
            measurementLabel.bottomAnchor.constraint(equalTo: appResetLabel.topAnchor, constant: -25),
            measurementLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            measurementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            measurementLabel.heightAnchor.constraint(equalToConstant: 75),
            
            measurmentIcon.centerYAnchor.constraint(equalTo: measurementLabel.centerYAnchor),
            measurmentIcon.centerXAnchor.constraint(equalTo: appResetIcon.centerXAnchor),
            measurmentIcon.heightAnchor.constraint(equalToConstant: 40),
            measurmentIcon.widthAnchor.constraint(equalToConstant: 25),
            
            measurmentTitleLabel.centerYAnchor.constraint(equalTo: measurementLabel.centerYAnchor),
            measurmentTitleLabel.leadingAnchor.constraint(equalTo: measurmentIcon.trailingAnchor, constant: 10),
            measurmentTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            fahrenheitText.centerYAnchor.constraint(equalTo: measurementLabel.centerYAnchor),
            fahrenheitText.trailingAnchor.constraint(equalTo: measurementLabel.trailingAnchor, constant: -15),
            fahrenheitText.heightAnchor.constraint(equalToConstant: 35),
            
            switcher.centerYAnchor.constraint(equalTo: measurementLabel.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: fahrenheitText.leadingAnchor, constant: -5),
            switcher.widthAnchor.constraint(equalToConstant: 51),
            switcher.heightAnchor.constraint(equalToConstant: 31),
            
            celsiusText.trailingAnchor.constraint(equalTo: switcher.leadingAnchor, constant: -5),
            celsiusText.centerYAnchor.constraint(equalTo: measurementLabel.centerYAnchor),
            celsiusText.heightAnchor.constraint(equalToConstant: 35),

            
            appResetLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            appResetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            appResetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            appResetLabel.heightAnchor.constraint(equalToConstant: 75),
            
            appResetIcon.centerYAnchor.constraint(equalTo: appResetLabel.centerYAnchor),
            appResetIcon.leadingAnchor.constraint(equalTo: appResetLabel.leadingAnchor, constant: 20),
            appResetIcon.heightAnchor.constraint(equalToConstant: 35),
            appResetIcon.widthAnchor.constraint(equalToConstant: 35),
            
            appResetTitleLabel.centerYAnchor.constraint(equalTo: appResetLabel.centerYAnchor),
            appResetTitleLabel.leadingAnchor.constraint(equalTo: measurmentTitleLabel.leadingAnchor),
            
            appResetImageButton.centerYAnchor.constraint(equalTo: appResetLabel.centerYAnchor),
            appResetImageButton.trailingAnchor.constraint(equalTo: appResetLabel.trailingAnchor, constant: -25),
            appResetImageButton.heightAnchor.constraint(equalToConstant: 36),
            appResetImageButton.widthAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    // MARK: - Search Controller Methods
    
    private func setupSearchController() {
        let resultVC = ResultViewController()
        searchController = UISearchController(searchResultsController: resultVC)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        styleSearchBar()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        let filteredCities = viewModel.searchCities(by: text)
        
        if let resultVC = searchController.searchResultsController as? ResultViewController {
            resultVC.citiesArray = filteredCities
            
            resultVC.onCitySelected = { [weak self] city in
                guard let self = self else { return }
                self.locationTitleLabel.text = city.name
                self.searchController.dismiss(animated: true)
                UIView.transition(
                    with: self.searchController.searchBar,
                    duration: 0.2,
                    options: .transitionCrossDissolve,
                    animations: {
                        self.searchController.searchBar.text = ""
                    },
                    completion: nil
                )
            }
        }
    }
    
    // MARK: - API Methods
    private func bindHistoryData() {
        let cityName = UserDefaults.standard.string(forKey: "lastSelectedCity") ?? "London"
        locationTitleLabel.text = cityName
    }
    
    // MARK: - Set targets
    
    private func setTargets() {
        self.switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        self.appResetImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetApp)))
    }
    
    
    
    // MARK: - Selectors
    
    @objc func switchValueChanged() {
        UserDefaults.standard.set(self.switcher.isOn, forKey: "isMetric")
        NotificationCenter.default.post(name: Notification.Name("unitsDidChange"), object: nil)
    }
    
    @objc func resetApp() {
        let alert = UIAlertController(title: "Are you sure you want to reset the app?", message: "All saved data, including selected city and settings, will be permanently deleted. This action cannot be undone.", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            self.reset()
        }
        
        alert.addAction(cancel)
        alert.addAction(yes)
        
        present(alert, animated: true)
    }
    
    // MARK: - Additional func
    
    private func reset() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "lastSelectedCity")
        defaults.removeObject(forKey: "isMetric")
        defaults.synchronize()
        
        self.switcher.isOn = false
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive}) as? UIWindowScene {
            let window = sceneDelegate.windows.first
            let splashVC = SplashViewController()
            window?.rootViewController = splashVC
            
            UIView.transition(with: window!,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
            
        } else if let window = UIApplication.shared.delegate?.window ?? nil {
            let splashVC = SplashViewController()
            window.rootViewController = splashVC
            
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
}

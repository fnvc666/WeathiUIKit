//
//  WeatherHistoryViewController.swift
//  Weathi
//
//  Created by on 09/03/2025.
//

import UIKit

class WeatherHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    
    private let viewModel = HistoryViewModel()
    
    // MARK: - UI Components
    
    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 154/255, green: 199/255, blue: 213/255, alpha: 1)
        tableView.register(WeatherHistoryCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Setup UI Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 154/255, green: 199/255, blue: 213/255, alpha: 1)
        
        view.addSubview(historyTableView)
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        setupConstraints()
        setNotification()
        bindHistoryData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    // MARK: - tableView Methods
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 33
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.historyWeatherData.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherHistoryCell else {
                return UITableViewCell()
            }
        
        if let dayData = viewModel.historyWeatherData.value?[indexPath.section] {
            cell.configure(with: dayData, hourly: dayData.data?.first)
            print("\n \n \n \(dayData)")
        }
        return cell
    }

    
    // MARK: - API Methods
    
    private func bindHistoryData() {
        let cityName = UserDefaults.standard.string(forKey: "lastSelectedCity")
        viewModel.loadHistory(for: cityName ?? "London")
        viewModel.historyWeatherData.bind { [weak self] _ in
            self?.historyTableView.reloadData()
        }
    }

    // MARK: - Notification Mathods
    
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
    
    @objc func cityDidChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let cityName = userInfo["cityName"] as? String
        else { return }
        
        viewModel.loadHistory(for: cityName)
    }
    
    @objc func unitsDidChange(_ notification: Notification) {
        let cityName = UserDefaults.standard.string(forKey: "lastSelectedCity") ?? "London"
        viewModel.loadHistory(for: cityName)
    }
}

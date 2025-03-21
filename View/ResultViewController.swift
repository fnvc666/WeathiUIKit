//
//  ResultViewController.swift
//  Weathi
//
//  Created by on 17/03/2025.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    var citiesArray: [CityEntity] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var onCitySelected: ((CityEntity) -> Void)?
    
    // MARK: - UI Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
        tableView.register(ResultCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Set UI Methods
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ])
    }
    
    // MARK: - TableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell? else {
            return UITableViewCell()
        }
        
        cell.configure(city: citiesArray[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = citiesArray[indexPath.section]
        onCitySelected!(city)
        UserDefaults.standard.set(city.name, forKey: "lastSelectedCity")
        
        NotificationCenter.default.post(
            name: Notification.Name("cityDidChange"),
            object: nil,
            userInfo: ["cityName": city.name]
        )
    }
}

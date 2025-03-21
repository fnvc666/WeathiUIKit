//
//  TabBarController.swift
//  Weathi
//
//  Created by on 12/03/2025.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var firstScreenColor: UIColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        setupVCs()
        setInitialAppearance()
        loadViewIfNeeded()
    }
    
    private func setupVCs() {
        let weatherVC = WeatherViewController()
        weatherVC.tabBarItem = UITabBarItem(
            title: " ",
            image: UIImage(systemName: "sun.max"),
            selectedImage: UIImage(systemName: "sun.max.fill")
        )
        
        weatherVC.onChangeColor = { [weak self] newColor in
            self?.updateTabBarAppearance(with: newColor)
        }
        
        let weatherHistoryVC = WeatherHistoryViewController()
        weatherHistoryVC.tabBarItem = UITabBarItem(
            title: " ",
            image: UIImage(systemName: "clock"),
            selectedImage: UIImage(systemName: "clock.fill"))
        
        let settingsVC = SettingsViewController()
        let settingsNavController = UINavigationController(rootViewController: settingsVC)
        settingsNavController.tabBarItem = UITabBarItem(
            title: " ",
            image: UIImage(systemName: "location"),
            selectedImage: UIImage(systemName: "location.fill"))
        
        viewControllers = [weatherVC, weatherHistoryVC, settingsNavController]
        view.backgroundColor = firstScreenColor
    }
    
    private func updateTabBarAppearance(with color: UIColor?) {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.backgroundColor = color?.withAlphaComponent(0.75)
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    private func setInitialAppearance() {
        updateTabBarAppearance(with: firstScreenColor)
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navVC = viewController as? UINavigationController {
            updateTabBarAppearance(with: navVC.topViewController?.view.backgroundColor)
        } else {
            updateTabBarAppearance(with: viewController.view.backgroundColor)
        }
    }

}

//
//  SplashViewController.swift
//  Weathi
//
//  Created by on 09/03/2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cloud"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Weathi"
        label.textColor = UIColor(red: 230/255, green: 231/255, blue: 230/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "IBMPlexSansJP-Regular", size: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = UIColor(red: 174/255, green: 180/255, blue: 174/255, alpha: 1)
        progressView.progressTintColor = UIColor(red: 240/255, green: 242/255, blue: 243/255, alpha: 1)
        progressView.progress = 0.33
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        startLoading()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
        
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        view.addSubview(progressView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 255),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87),
            logoImageView.widthAnchor.constraint(equalToConstant: 220),
            logoImageView.heightAnchor.constraint(equalToConstant: 179),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 26),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 117),
            nameLabel.widthAnchor.constraint(equalToConstant: 160),
            nameLabel.heightAnchor.constraint(equalToConstant: 55),
            
            progressView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 181),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            progressView.widthAnchor.constraint(equalToConstant: 314),
            progressView.heightAnchor.constraint(equalToConstant: 6),
            ])
    }
    
    // MARK: - ProgressView Methods
    
    private func startLoading() {
        progressView.setProgress(0, animated: false)
        
        var currentProgress: Float = 0
        let targetProgress: Float = 1.0
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            if currentProgress < targetProgress {
                let progressStep: Float = 0.01
                currentProgress += progressStep
                self.progressView.setProgress(currentProgress, animated: true)
            } else {
                timer.invalidate()
                self.finishLoading()
            }
        }
    }
    
    private func finishLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }) { _ in
            let tabBarVC = TabBarController()
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                sceneDelegate.windows.first?.rootViewController = tabBarVC
                sceneDelegate.windows.first?.makeKeyAndVisible()
            }
        }
    }

}

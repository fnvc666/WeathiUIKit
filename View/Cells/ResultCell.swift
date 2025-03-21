//
//  ResultTableViewCell.swift
//  Weathi
//
//  Created by on 18/03/2025.
//

import UIKit

class ResultCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI Methods
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
        
        contentView.addSubview(cityLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
        ])
    }
    
    // MARK: - Selection
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Configuration
    
    func configure(city: CityEntity) {
        cityLabel.text = city.name
    }

}

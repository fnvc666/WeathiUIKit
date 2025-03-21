import UIKit

class WeatherHistoryCell: UITableViewCell {
    
    var tempData: HistoryWeatherData!
    
    // MARK: - UI Components
    
    private let cardBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Light", size: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Sunny"
        label.font = UIFont(name: "IBMPlexSansThaiLooped-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.558, green: 0.558, blue: 0.558, alpha: 1)
        label.textAlignment = .left
        label.text = "12:00"
        label.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunHistory")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.558, green: 0.558, blue: 0.558, alpha: 1)
        label.textAlignment = .center
        label.text = "Mon. Mar 3"
        label.font = UIFont(name: "IBMPlexSansThaiLooped-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        
        contentView.addSubview(cardBackgroundView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(dateLabel)
        cardBackgroundView.addSubview(temperatureLabel)
        cardBackgroundView.addSubview(weatherLabel)
        cardBackgroundView.addSubview(iconImageView)
        
        layer.cornerRadius = 24
        layer.masksToBounds = true
        clipsToBounds = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardBackgroundView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            
            temperatureLabel.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 10),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 70),
            
            weatherLabel.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: 35),
            weatherLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: -20),
            weatherLabel.heightAnchor.constraint(equalToConstant: 33),
            weatherLabel.widthAnchor.constraint(equalToConstant: 57),
            
            timeLabel.topAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor, constant: 12),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            timeLabel.heightAnchor.constraint(equalToConstant: 15),
            
            iconImageView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: 13),
            iconImageView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -18),
            iconImageView.heightAnchor.constraint(equalToConstant: 56),
            iconImageView.widthAnchor.constraint(equalToConstant: 56),
            
            dateLabel.topAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor, constant: 12),
            dateLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            dateLabel.widthAnchor.constraint(equalToConstant: 88),
        ])
    }
    
    // MARK: - Theme Methods
    
    private func setTheme(status: Int) {
        switch status {
            case 701...800:
                let newColor = UIColor(red: 0.302, green: 0.631, blue: 0.733, alpha: 1)
                cardBackgroundView.backgroundColor = newColor
                iconImageView.image = UIImage(named: "sunHistory")
                
            case 801...804:
                let newColor = UIColor(red: 0.576, green: 0.682, blue: 0.643, alpha: 1)
                cardBackgroundView.backgroundColor = newColor
                iconImageView.image = UIImage(named: "cloudHistory")

            case 200...781:
                let newColor = UIColor(red: 0.192, green: 0.353, blue: 0.573, alpha: 1)
                cardBackgroundView.backgroundColor = newColor
                iconImageView.image = UIImage(named: "rainHistory")
                
            default:
                print("Default")
        }
    }
    
    // MARK: - Layout Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(
            roundedRect: cardBackgroundView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 24, height: 24)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        cardBackgroundView.layer.mask = mask
    }
    
    // MARK: - Configuration
    
    func configure(with dayData: HistoryWeatherData, hourly: HistoryWeatherData.HourlyWeatherData?) {
        if let status = dayData.data?.first?.weather.first?.id {
            setTheme(status: status)
            tempData = dayData
        }
        
        if let dt = hourly?.dt {
            let date = Date(timeIntervalSince1970: TimeInterval(dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            dateLabel.text = formatter.string(from: date)
            timeLabel.text = self.formatTime(timestamp: TimeInterval(dt), timezoneOffset: UserDefaults.standard.string(forKey: "timezoneOffset")!)
        } else {
            dateLabel.text = "no data"
            timeLabel.text = "no data"
        }
        
        if let temp = hourly?.temp {
            temperatureLabel.text = String(format: "%.0f°", temp)
        } else {
            temperatureLabel.text = "no data"
        }
        
        if let name = dayData.data?.first?.weather.first?.main {
            weatherLabel.text = name
        } else {
            weatherLabel.text = "no date"
        }
    }
    
    // MARK: - Selection
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func formatTime(timestamp: TimeInterval, timezoneOffset: String) -> String {
        print("timezoneOffset: \(timezoneOffset)")
        let date = Date(timeIntervalSince1970: timestamp + TimeInterval(timezoneOffset)!)
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
}

//
//  ContainerView.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class ContainerView: UIView {

    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow, RU"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "24 авг 2022"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "15º"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow-1, for: .vertical)
        return label
    }()
    
    let conditionsImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "drop")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow-1, for: .vertical)
        view.setContentHuggingPriority(.defaultLow-1, for: .horizontal)
        return view
    }()
    
    let conditionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Clouds"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thermometerImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "thermometer")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    
    private let windImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wind")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    
    private let humidityImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "drop")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    
    private lazy var iconStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thermometerImage, windImage, humidityImage])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    let percievedTempLabel: UILabel = {
        let label = UILabel()
        label.text = "15º"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let speedLabel: UILabel = {
        let label = UILabel()
        label.text = "4 km/h"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let hymidityLabel: UILabel = {
        let label = UILabel()
        label.text = "86 %"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var indicatorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [percievedTempLabel, speedLabel, hymidityLabel])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let percTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Percieved"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = .center
        return label
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = .center
        return label
    }()
    
    private let hymLabel: UILabel = {
        let label = UILabel()
        label.text = "Hymidity"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exampleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [percTempLabel, windLabel, hymLabel])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var complexStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconStackView, indicatorStackView, exampleStackView])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(conditionsImage)
        addSubview(conditionsLabel)
        addSubview(temperatureLabel)
        addSubview(complexStackView)
        
        let conditionsImageTrailingConstraint = conditionsImage.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        conditionsImageTrailingConstraint.priority = .defaultLow
        
        //добавить directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0) внутри containerView
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            locationLabel.widthAnchor.constraint(equalTo: dateLabel.widthAnchor, multiplier: 1.5),
            
            dateLabel.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            conditionsImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            conditionsImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            conditionsImage.bottomAnchor.constraint(equalTo: conditionsLabel.topAnchor),
            conditionsImage.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor),
            
            conditionsLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            conditionsLabel.trailingAnchor.constraint(equalTo: conditionsImage.trailingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: conditionsImage.bottomAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            complexStackView.topAnchor.constraint(equalTo: conditionsLabel.bottomAnchor),
            complexStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            complexStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            complexStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            conditionsImageTrailingConstraint
        ])
    }
}

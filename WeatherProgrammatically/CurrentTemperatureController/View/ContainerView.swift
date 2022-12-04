//
//  GeneralView.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class ContainerView: UIView {

    private let locationLabel: UILabel = {
        let label = UILabel()
//        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
//        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
//        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionsImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "drop")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let conditionsLabel: UILabel = {
        let label = UILabel()
//        label.text = ""
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
        return view
    }()
    
    private let windImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wind")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let humidityImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "drop")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var iconStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thermometerImage, windImage, humidityImage])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let percievedTempLabel: UILabel = {
        let label = UILabel()
//        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
//        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let hymidityLabel: UILabel = {
        let label = UILabel()
//        label.text = ""
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
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let percTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Percieved"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let hymLabel: UILabel = {
        let label = UILabel()
        label.text = "Hymidity"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exampleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [percTempLabel, windLabel, hymLabel])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var complexStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconStackView, indicatorStackView, exampleStackView])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fill
        stackView.alignment = .center
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
        
        //добавить directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0) внутри containerView
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            locationLabel.widthAnchor.constraint(equalTo: dateLabel.widthAnchor, multiplier: 1.5),
            
            dateLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            conditionsImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            conditionsImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            conditionsImage.bottomAnchor.constraint(equalTo: conditionsLabel.topAnchor),
            conditionsImage.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor),
            
            conditionsLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            conditionsLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            complexStackView.topAnchor.constraint(equalTo: conditionsLabel.bottomAnchor),
            complexStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            complexStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            complexStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}

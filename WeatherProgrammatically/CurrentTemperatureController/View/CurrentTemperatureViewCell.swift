//
//  CurrentTemperatureViewCell.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class CurrentTemperatureViewCell: UICollectionViewCell {
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "15:30"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "drop")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow-1, for: .vertical)
        return view
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "15º"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(timeLabel)
        addSubview(imageView)
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: timeLabel.bottomAnchor, multiplier: 1.0),
            imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1.0),
            temperatureLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}

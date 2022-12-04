//
//  MainTemperatureViewCell.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class CurrentTemperatureViewCell: UICollectionViewCell {
    
    private let conditionsImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "drop")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(conditionsImage)
        
        NSLayoutConstraint.activate([
            conditionsImage.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            conditionsImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            conditionsImage.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            conditionsImage.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}

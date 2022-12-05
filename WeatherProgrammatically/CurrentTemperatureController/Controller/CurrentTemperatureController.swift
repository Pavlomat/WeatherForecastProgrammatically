//
//  CurrentTemperatureController.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class CurrentTemperatureController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let containerView: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        return view
    }()
    
    private let hourlyForecastHeader: UILabel = {
        let label = UILabel()
        label.text = "Today Hourly Forecast"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        view.register(CurrentTemperatureViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    private lazy var currecntLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Current Location", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var refreshForecastButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Refresh Forecast", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(refreshForecastButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addCityButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Add City", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(addCityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currecntLocationButton, refreshForecastButton, addCityButton])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.731, green: 0.937, blue: 0.999, alpha: 1)
        
        setupView()
        
        collectionView.register(CurrentTemperatureViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupView() {
        view.addSubview(containerView)
        view.addSubview(hourlyForecastHeader)
        view.addSubview(collectionView)
        view.addSubview(currecntLocationButton)
        view.addSubview(buttonStackView)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: margins.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            hourlyForecastHeader.topAnchor.constraint(equalToSystemSpacingBelow: containerView.bottomAnchor, multiplier: 1.0),
            hourlyForecastHeader.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            hourlyForecastHeader.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: hourlyForecastHeader.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            buttonStackView.topAnchor.constraint(equalToSystemSpacingBelow: collectionView.bottomAnchor, multiplier: 1.0),
            buttonStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
        let outletsArray = [containerView, refreshForecastButton, addCityButton, addCityButton, currecntLocationButton]
        
        for i in outletsArray {
            i.layer.borderWidth = 2
            i.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
            i.layer.cornerRadius = 15
        }
    }
    
    @objc private func currentLocationButtonTapped() {
        containerView.locationLabel.text = "San Francisco"
    }
    
    @objc private func refreshForecastButtonTapped() {
        
    }
    
    @objc private func addCityButtonTapped() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CurrentTemperatureViewCell else { fatalError() }
        cell.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height-20)
    }
}

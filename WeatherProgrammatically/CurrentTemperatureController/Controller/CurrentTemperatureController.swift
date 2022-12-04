//
//  ViewController1.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class CurrentTemperatureController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let containerView: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
        let view = UICollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CurrentTemperatureViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.collectionViewLayout = layout
        return view
    }()
    
    private lazy var currecntLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .label
        button.setTitle("Current Location", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
//        button.directionalLayoutMargins = NSDirectionalEdgeInsets(top: <#T##CGFloat#>, leading: <#T##CGFloat#>, bottom: <#T##CGFloat#>, trailing: <#T##CGFloat#>)
        button.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var refreshForecastButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .label
        button.setTitle("Refresh Forecast", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
//        button.directionalLayoutMargins = NSDirectionalEdgeInsets(top: <#T##CGFloat#>, leading: <#T##CGFloat#>, bottom: <#T##CGFloat#>, trailing: <#T##CGFloat#>)
        button.addTarget(self, action: #selector(refreshForecastButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addCityButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .label
        button.setTitle("Add City", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
//        button.directionalLayoutMargins = NSDirectionalEdgeInsets(top: <#T##CGFloat#>, leading: <#T##CGFloat#>, bottom: <#T##CGFloat#>, trailing: <#T##CGFloat#>)
        button.addTarget(self, action: #selector(addCityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currecntLocationButton, refreshForecastButton, addCityButton])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        setupView()
        
        collectionView.register(CurrentTemperatureViewCell.self, forCellWithReuseIdentifier: "Cell")
//        collectionView.cellLayoutMarginsFollowReadableWidth = true
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
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            hourlyForecastHeader.topAnchor.constraint(equalToSystemSpacingBelow: containerView.bottomAnchor, multiplier: 1.0),
            hourlyForecastHeader.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            hourlyForecastHeader.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: hourlyForecastHeader.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            buttonStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
    
    @objc private func currentLocationButtonTapped() {
        
    }
    
    @objc private func refreshForecastButtonTapped() {
        
    }
    
    @objc private func addCityButtonTapped() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CurrentTemperatureViewCell else { fatalError() }
        cell.backgroundColor = .blue
        return cell
    }
}

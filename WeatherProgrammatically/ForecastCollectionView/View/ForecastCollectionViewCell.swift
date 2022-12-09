//
//  ForecastCollectionViewCell.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday"
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ForecastInternalCell.self, forCellWithReuseIdentifier: "Cell")
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        return view
    }()
    
    var dailyForecast: [DayForecast] = []
   
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        collectionView.register(ForecastInternalCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(dayLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            dayLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.3),
            
            collectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: dayLabel.trailingAnchor, multiplier: 1.0),
            collectionView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ForecastInternalCell else { fatalError() }
        cell.backgroundColor = UIColor(red: 0.731, green: 0.937, blue: 0.999, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 15
        let data = dailyForecast[indexPath.item]
        cell.temperatureLabel.text = data.temp.kelvinToCeliusConverter() + "º"
        cell.timeLabel.text = data.time.correctTime()
        cell.imageView.loadImageFromURL(url: "https://openweathermap.org/img/wn/\(data.icon)@2x.png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height-20)
    }
    
    func configure(with item: ForecastTemperature) {
        dailyForecast = item.hourlyForecast ?? []
    }
}

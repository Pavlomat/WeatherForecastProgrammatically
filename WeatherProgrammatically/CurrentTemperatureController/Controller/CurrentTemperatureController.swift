//
//  CurrentTemperatureController.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit
import CoreLocation

class CurrentTemperatureController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    private let containerView: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        return view
    }()
    
    private let hourlyForecastHeader: UILabel = {
        let label = UILabel()
        label.text = "Today Hourly Forecast"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
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
    
    let networkManager = NetworkManager()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    var forecastData: [ForecastTemperature] = []
    var currentDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil, cityName: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.731, green: 0.937, blue: 0.999, alpha: 1)
        
        setupView()
        
        collectionView.register(CurrentTemperatureViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        locationManager.delegate = self
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
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
                locationManager.requestWhenInUseAuthorization()
                break
                
            case .restricted, .denied:
                currecntLocationButton.isHidden = true
                let ac = UIAlertController(title: "Location denied", message: "App needs access to your location. Turn on Location Services in your device settings or provide city.", preferredStyle: UIAlertController.Style.alert)
                ac.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }))
                ac.addAction(UIAlertAction(title: "Provide", style: UIAlertAction.Style.default) { [weak self] _ in
                    let ac = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
                    ac.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "City Name"
                    }
                    let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
                        let firstTextField = ac.textFields![0] as UITextField
                        guard let city = firstTextField.text else { return }
                        self?.loadDataUsingCity(city: city)
                        self?.loadForecastUsingCity(city: city)
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
                        print("Cancel")
                    })
                    ac.addAction(saveAction)
                    ac.addAction(cancelAction)
                    self?.present(ac, animated: true)
                })
                DispatchQueue.main.async{
                    self.present(ac, animated: true)
                }
                break
                
            case .authorizedWhenInUse, .authorizedAlways:
                currecntLocationButton.isHidden = false
                locationManager.startUpdatingLocation()
                guard let location = locationManager.location?.coordinate else { return }
                latitude = location.latitude
                longitude = location.longitude
                loadDataUsingCoordinates(lat: latitude.description, lon: longitude.description)
                loadForecastUsingCoordinates(lat: latitude.description, lon: longitude.description)
                break
            @unknown default:
                fatalError()
            }
        }
    }
    
    func loadDataUsingCoordinates(lat: String, lon: String) {
        networkManager.fetchCurrentLocationWeather(lat: lat, lon: lon) { (weather) in
            DispatchQueue.main.async {
                self.setLabels(weather: weather)
            }
        }
    }
    
    func loadDataUsingCity(city: String) {
        networkManager.fetchCurrentWeather(city: city) { (weather) in
            DispatchQueue.main.async {
                self.setLabels(weather: weather)
            }
        }
    }
    
    func loadForecastUsingCity(city: String) {
        networkManager.fetchNextFiveWeatherForecast(city: city) { [weak self] (forecast) in
            self?.forecastData = forecast
            self?.currentDayTemp = (self?.forecastData[0])!
            UserDefaults.standard.set("\(self?.forecastData[0].cityName ?? "")", forKey: "SelectedCity")
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func setLabels(weather: Weather) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt ?? 0)))
        
        containerView.temperatureLabel.text = (weather.main?.temp?.kelvinToCeliusConverter())! + "º"
        containerView.locationLabel.text = "\(weather.name ?? "") , \(weather.sys?.country ?? "")"
        containerView.dateLabel.text = stringDate
        containerView.percievedTempLabel.text = "\(weather.main?.feelsLike?.kelvinToCeliusConverter() ?? "")" + "º"
        containerView.speedLabel.text = "\(weather.wind?.speed?.cutFractional() ?? "")" + " km/h"
        containerView.hymidityLabel.text = "\(weather.main?.humidity ?? 0)" + " %"
        containerView.conditionsLabel.text = "\(weather.weather?[0].main ?? "")"
        if let iconUrl = weather.weather?[0].icon {
            containerView.conditionsImage.loadImageFromURL(url: "https://openweathermap.org/img/wn/\(iconUrl)@2x.png") }
        UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
    }
    
    func loadForecastUsingCoordinates(lat: String, lon: String) {
        networkManager.fetchNextFiveWeatherForecastCoordinates(lat: lat, lon: lon) { [weak self] (forecast) in
            self?.forecastData = forecast
            self?.currentDayTemp = (self?.forecastData[0])!
            UserDefaults.standard.set("\(self?.forecastData[0].cityName ?? "")", forKey: "SelectedCity")
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc private func currentLocationButtonTapped() {
        loadDataUsingCoordinates(lat: latitude.description, lon: longitude.description)
        loadForecastUsingCoordinates(lat: latitude.description, lon: longitude.description)
    }
    
    @objc private func refreshForecastButtonTapped() {
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        loadDataUsingCity(city: city)
        loadForecastUsingCity(city: city)
    }
    
    @objc private func addCityButtonTapped() {
        let ac = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        ac.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "City Name"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            let firstTextField = ac.textFields![0] as UITextField
            guard let city = firstTextField.text else { return }
            self?.loadDataUsingCity(city: city)
            self?.loadForecastUsingCity(city: city)
            UserDefaults.standard.set("\(city)", forKey: "SelectedCity")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        ac.addAction(saveAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDayTemp.hourlyForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CurrentTemperatureViewCell else { fatalError() }
        cell.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 15
        let data = currentDayTemp.hourlyForecast![indexPath.item]
        cell.temperatureLabel.text = data.temp.kelvinToCeliusConverter() + "º"
        cell.timeLabel.text = data.time.correctTime()
        cell.imageView.loadImageFromURL(url: "https://openweathermap.org/img/wn/\(data.icon)@2x.png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height-20)
    }
}

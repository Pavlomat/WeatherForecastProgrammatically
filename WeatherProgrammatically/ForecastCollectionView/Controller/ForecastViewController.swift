//
//  ForecastViewController.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class ForecastViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor(red: 0.731, green: 0.937, blue: 0.999, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ForecastCollectionViewCell else { fatalError() }
        cell.backgroundColor = UIColor(red: 0.824, green: 0.960, blue: 0.998, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.height/4)
    }
}

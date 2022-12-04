//
//  TabBarController.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 04.12.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .label
           setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.isNavigationBarHidden = true
//        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.isTranslucent = false
//        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: CurrentTemperatureController(), title: NSLocalizedString("First", comment: ""), image: UIImage(systemName: "1.circle")!),
            createNavController(for: ForecastViewController(), title: NSLocalizedString("Second", comment: ""), image: UIImage(systemName: "2.circle")!)
        ]
    }
}

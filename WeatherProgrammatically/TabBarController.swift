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
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        tabBar.tintColor = .cyan
           setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.isNavigationBarHidden = true
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: CurrentTemperatureController(), title: NSLocalizedString("Today", comment: ""), image: UIImage(systemName: "calendar.badge.exclamationmark")!),
            createNavController(for: ForecastViewController(), title: NSLocalizedString("Tomorrow", comment: ""), image: UIImage(systemName: "calendar")!)
        ]
    }
}

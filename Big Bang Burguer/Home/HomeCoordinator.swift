//
//  HomeCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 04/07/24.
//

import Foundation
import UIKit

class HomeCoordinator {
    
    private let window: UIWindow?
//    private var navigationController = UINavigationController()
    
    let feedVC = UINavigationController()
    let couponVC = UINavigationController()
    let profileVC = UINavigationController()

    init(window: UIWindow?) {
        self.window = window
//        self.navigationController = UINavigationController()
    }
    
    func start() {
        let viewModel = HomeViewModel()
        viewModel.coordinator = self
        
        let homeVC = HomeViewController()
        homeVC.viewModel = viewModel
//        navigationController.pushViewController(homeVC, animated: true)
        
        let feedCoordinator = FeedCoordinator(feedVC)
        feedCoordinator.start()
                
        homeVC.setViewControllers([feedVC], animated: true)
        window?.rootViewController = homeVC
//        window?.rootViewController = navigationController
    }
}

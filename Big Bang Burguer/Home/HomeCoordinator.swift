//
//  HomeCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 04/07/24.
//

import UIKit

class HomeCoordinator {
    
    private let window: UIWindow?

    let feedVC = UINavigationController()
    let profileVC = UINavigationController()
    let couponVC = UINavigationController()
    
    private var signInCoordinator: SignInCoordinator?

    init(_ window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeViewController()
        
        let feedCoordinator = FeedCoordinator(feedVC)
        feedCoordinator.parentCoordinator = self
        feedCoordinator.start()
        
        let profileCoordinator = ProfileCoordinator(profileVC)
        profileCoordinator.start()
        
        let couponCoordinator = CouponCoordinator(couponVC)
        couponCoordinator.start()
        
        homeVC.setViewControllers([feedVC, profileVC, couponVC], animated: true)
        window?.rootViewController = homeVC
    }
    
    func goToLogin() {
        signInCoordinator = SignInCoordinator(window)
        signInCoordinator?.start()
    }
}

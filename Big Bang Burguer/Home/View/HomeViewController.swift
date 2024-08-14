//
//  HomeViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 04/07/24.
//

import UIKit

class HomeViewController: UITabBarController {
    
    var viewModel: HomeViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
//        let feedInteractor = FeedInteractor()
//        let feedViewModel = FeedViewModel(interactor: feedInteractor)
//        let feedVC = FeedViewController()
//        feedVC.viewModel = feedViewModel
         
//        let navFeedVC = UINavigationController(rootViewController: feedVC)
//        navFeedVC.tabBarItem.image = UIImage(systemName: "house")
//        navFeedVC.title = "Home"
        
//        let couponVC = UINavigationController(rootViewController: CouponViewController())
//        couponVC.tabBarItem.image = UIImage(systemName: "ticket")
//        couponVC.title = "Cupons"
//        
//        let profileVC = UINavigationController(rootViewController: ProfileViewController())
//        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
//        profileVC.title = "Perfil"
//        
        tabBar.tintColor = .systemRed
//        
//        setViewControllers([navFeedVC, couponVC, profileVC], animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func viewModelDidChanged(state: SignUpState) {
        // algo aqui
    }
}

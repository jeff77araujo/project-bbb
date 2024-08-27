//
//  FeedCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 29/07/24.
//

import UIKit

class FeedCoordinator {
    
    private let navigationController: UINavigationController
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = FeedInteractor()
        let viewModel = FeedViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let feedVC = FeedViewController()
        feedVC.viewModel = viewModel
                
        navigationController.pushViewController(feedVC, animated: true)
    }
    
    func goToProductDetail(id: Int) {
        let coordinator = ProductDetailCoordinator(navigationController, id: id)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func goToLogin() {
        parentCoordinator?.goToLogin()
    }
}

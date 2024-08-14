//
//  ProductDetailCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 01/08/24.
//

import UIKit

class ProductDetailCoordinator {
    
    private let navigationController: UINavigationController
    private let id: Int
    
    var parentCoordinator: FeedCoordinator?

    init(_ navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let interactor = ProductDetailInteractor()
        
        let viewModel = ProductDetailViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let productVC = ProductDetailViewController()
        productVC.id = id
        productVC.viewModel = viewModel
        
        navigationController.pushViewController(productVC, animated: true)
    }
}

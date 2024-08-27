//
//  CouponCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 20/08/24.
//

import UIKit

class CouponCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = CouponInteractor()
        
        let viewModel = CouponViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let couponVC = CouponViewController(style: .grouped)
        couponVC.viewModel = viewModel
                
        navigationController.pushViewController(couponVC, animated: true)
    }
}

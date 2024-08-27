//
//  ProfileCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 17/08/24.
//

import UIKit

class ProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = ProfileInteractor()
        
        let viewModel = ProfileViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let profileVC = ProfileViewController(style: .grouped)
        profileVC.viewModel = viewModel
                
        navigationController.pushViewController(profileVC, animated: true)
    }
}

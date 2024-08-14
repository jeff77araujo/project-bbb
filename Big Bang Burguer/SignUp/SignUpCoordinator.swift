//
//  SignUpCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 03/07/24.
//

import Foundation
import UIKit

class SignUpCoordinator {
    
    private var navigationController = UINavigationController()
    var parentCoordinator: SignInCoordinator?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let interactor = SignUpInteractor()
        
        let viewModel = SignUpViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let signUpVC = SignUpViewController()
        signUpVC.viewModel = viewModel
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func login() {
//        parentCoordinator?.hom e()
        navigationController.popViewController(animated: true)
    }
}

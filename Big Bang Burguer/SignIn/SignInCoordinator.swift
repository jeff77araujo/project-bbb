//
//  SignInCoordinator.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 03/07/24.
//

import Foundation
import UIKit

class SignInCoordinator {
     
    private let window: UIWindow?
    private var navigationController = UINavigationController()
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let interactor = SignInInteractor()
        
        let viewModel = SignInViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let signInVC = SignInViewController()
        signInVC.viewModel = viewModel
        
        navigationController.pushViewController(signInVC, animated: true)
        
        window?.rootViewController = navigationController
        
    }
    
    func signUp() {
        let signUpCoodinator = SignUpCoordinator(navigation: navigationController)
        signUpCoodinator.parentCoordinator = self
        signUpCoodinator.start()
    }
    
    func home() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
    }
}

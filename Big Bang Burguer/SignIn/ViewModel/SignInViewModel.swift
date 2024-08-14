//
//  SignInViewModel.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 02/07/24.
//

import Foundation

protocol SignInViewModelDelegate {
    func viewModelDidChanged(state: SigInState)
}

class SignInViewModel {
    
    var email = ""
    var password = ""
    
    var delegate: SignInViewModelDelegate?
    var coordinator: SignInCoordinator?
    
    private let interactor: SignInInteractor
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
    }
    
    var state: SigInState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send() {
        state = .loading
        
        let request = SignInRequest(username: email, password: password)
        
        interactor.login(request: request) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    print(response)
                    self.state = .goToHome
                }
            }
        }
    }
    
    func goToSignUp() {
        coordinator?.signUp()
    }
    
    func goToHome() {
        coordinator?.home()
    }
}

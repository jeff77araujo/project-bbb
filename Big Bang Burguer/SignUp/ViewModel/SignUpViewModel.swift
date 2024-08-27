//
//  SignUpViewModel.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 03/07/24.
//

import Foundation

protocol SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState)
}

class SignUpViewModel {
    
    var name = ""
    var email = ""
    var password = ""
    var document = ""
    var birthday = ""
    
    var delegate: SignUpViewModelDelegate?
    var coordinator: SignUpCoordinator?
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    var state: SignUpState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send() {
        state = .loading
        
        let documentFormatted = document.onlyNumbers
        guard let birthdayFormatted = birthday.toDate()?.toString() else { return }
        
        let request = SignUpRequest(name: name,
                                    email: email,
                                    password: password,
                                    document: documentFormatted,
                                    birthday: birthdayFormatted)
        
        interactor.createUser(request: request) { created, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let _ = created {
                    self.state = .goToLogin
                }
            }
        }
    }
    
    func goToLogin() {
        coordinator?.login()
    }
}

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
        
        let dtString = DateFormatter()
        dtString.locale = Locale(identifier: "en_US_POSIX")
        dtString.dateFormat = "dd/MM/yyyy"
        
        guard let date = dtString.date(from: birthday) else { return }
        
        let dtDate = DateFormatter()
        dtDate.locale = Locale(identifier: "en_US_POSIX")
        dtDate.dateFormat = "yyyy-MM-dd"
        
        let birthdayFormatted = dtDate.string(from: date)
        
        let documentFormatted = document.digits
        
        let request = SignUpRequest(name: name,
                                    email: email,
                                    password: password,
                                    document: documentFormatted,
                                    birthday: birthdayFormatted)
        
        interactor.createUser(request: request) { created, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let created = created {
                    self.state = .goToLogin
                }
            }
        }
    }
    
    func goToLogin() {
        coordinator?.login()
    }
}

//
//  HomeViewModel.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 04/07/24.
//

import Foundation

protocol HomeViewModelDelegate {
    func viewModelDidChanged(state: SignUpState)
}

class HomeViewModel {
    
    var delegate: HomeViewModelDelegate?
    var coordinator: HomeCoordinator?
    
    var state: SignUpState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send() {
        state = .loading
        print("------------------------\n\n")
        print("Carregando na tela HOME")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state = .none
        }
    }
}

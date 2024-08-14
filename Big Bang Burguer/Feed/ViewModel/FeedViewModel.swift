//
//  FeedViewModel.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 26/07/24.
//

import Foundation

protocol FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState)
}

class FeedViewModel {
    
    var delegate: FeedViewModelDelegate?
    var coordinator: FeedCoordinator?
    
    private let interactor: FeedInteractor
    
    init(interactor: FeedInteractor) {
        self.interactor = interactor
    }
    
    var state: FeedState = .loading  {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func fetch() {
        interactor.fetch() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .success(response)
                    print("------------------------\n\n")
                    print("FeedViewModel.fetch: \(response)")
                }
            }
        }
    }
    
    func fetchHighlight() {
        interactor.fetchHighlight() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .successHighlight(response)
                    print("------------------------\n\n")
                    print("fetchHighlight: \(response)")
                }
            }
        }
    }
    
    func goToProductDetail(id: Int) {
        coordinator?.goToProductDetail(id: id)
    }
    
//    func goToSignUp() {
//        coordinator?.signUp()
//    }
//    
//    func goToHome() {
//        coordinator?.home()
//    }
}

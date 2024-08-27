//
//  ProductDetailViewModel.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 07/08/24.
//

import Foundation

protocol ProductDetailViewModelDelegate {
    func viewModelDidChanged(state: ProductDetailState)
}

class ProductDetailViewModel {
    
    var delegate: ProductDetailViewModelDelegate?
    var coordinator: ProductDetailCoordinator?
    
    private let interactor: ProductDetailInteractor
    
    init(interactor: ProductDetailInteractor) {
        self.interactor = interactor
    }
    
    var state: ProductDetailState = .loading  {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func fetch(id: Int) {
        self.state = .loading
        interactor.fetch(id: id) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .success(response)
                }
            }
        }
    }
    
    func createCoupon(id: Int) {
        self.state = .loading
        interactor.createCoupon(id: id) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .successCoupon(response)
                }
            }
        }
    }
}

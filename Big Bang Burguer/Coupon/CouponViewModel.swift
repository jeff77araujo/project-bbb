//
//  CouponViewModel.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 20/08/24.
//

import Foundation

protocol CouponViewModelDelegate {
    func viewModelDidChanged(state: ProfileState)
}

class CouponViewModel {
    
    var delegate: CouponViewModelDelegate?
    var coordinator: CouponCoordinator?
    
    var state: ProfileState = .loading  {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: CouponInteractor
    
    init(interactor: CouponInteractor) {
        self.interactor = interactor
    }
    
    func fetchCoupons() {
        self.state = .loading
        interactor.fetchCoupons() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .success(response)
                    print("------------------------\n\n")
                    print("CouponViewModel.fetchCoupons: \(response)")
                }
            }
        }
    }
}

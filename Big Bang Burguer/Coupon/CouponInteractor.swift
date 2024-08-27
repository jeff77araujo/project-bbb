//
//  CouponInteractor.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 20/08/24.
//

import Foundation

class CouponInteractor {
    
    private let remote: CouponRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetchCoupons(completion: @escaping (UserResponse?, String?) -> Void) {
        return remote.fetchCoupons(completion: completion)
    }
}

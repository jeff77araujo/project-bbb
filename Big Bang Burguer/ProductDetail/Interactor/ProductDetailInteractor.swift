//
//  ProductDetailInteractor.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 07/08/24.
//

import Foundation

class ProductDetailInteractor {
    
    private let remote: ProductDetailRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(id: Int, completion: @escaping (ProductResponse?, String?) -> Void) {
        return remote.fetch(id: id, completion: completion)
    }
    
    func createCoupon(id: Int, completion: @escaping (CouponResponse?, String?) -> Void) {
        return remote.createCoupon(id: id, completion: completion)
    }
}

//
//  CouponResponse.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 14/08/24.
//

import Foundation

struct CouponResponse: Decodable {
    let id: Int
    let userId: Int
    let productId: Int
    let coupon: String
    let createdDate: String
    let expiresDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId  = "user_id"
        case productId = "product_id"
        case coupon
        case createdDate = "created_date"
        case expiresDate = "expires_date"
    }
}

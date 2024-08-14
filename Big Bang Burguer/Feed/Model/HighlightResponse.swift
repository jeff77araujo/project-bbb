//
//  HighlightResponse.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 31/07/24.
//

import Foundation

struct HighlightResponse: Decodable {
    let id: Int
    let pictureUrl: String
    let createdDate: String
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case pictureUrl = "picture_url"
        case createdDate = "created_date"
        case productId  = "product_id"
    }
}

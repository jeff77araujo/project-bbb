//
//  ResponseUnauthorized.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 23/07/24.
//

import Foundation

struct ResponseUnauthorized: Decodable {
    let detail: ResponseDetail
    
    enum CodingKeys: CodingKey {
        case detail
    }
}

struct ResponseDetail: Decodable {
    let message: String
    
    enum CodingKeys: CodingKey {
        case message
    }
}

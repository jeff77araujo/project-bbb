//
//  SignUpResponseError.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 22/07/24.
//

import Foundation

struct ResponseError: Decodable {
    let detail: String
    
    enum CodingKeys: CodingKey {
        case detail
    }
}

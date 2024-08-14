//
//  SignUpResponse.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 22/07/24.
//

import Foundation

struct SignUpResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case document
        case birthday
    }
}

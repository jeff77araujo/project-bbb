//
//  SignInRequest.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 23/07/24.
//

import Foundation

struct SignInRequest: Encodable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}

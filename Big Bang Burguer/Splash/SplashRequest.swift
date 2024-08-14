//
//  SplashRequest.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 25/07/24.
//

import Foundation
 
struct SplashRequest: Encodable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

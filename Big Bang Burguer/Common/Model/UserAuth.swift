//
//  UserAuth.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 24/07/24.
//

import Foundation

struct UserAuth: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String
}

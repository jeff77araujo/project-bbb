//
//  UserResponse.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 19/08/24.
//

import Foundation

struct UserResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
}

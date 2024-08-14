//
//  SignUpState.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 03/07/24.
//

import Foundation

enum SignUpState {
    case none
    case loading
    case goToLogin
    case error(String)
}

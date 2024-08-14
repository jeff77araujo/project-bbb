//
//  SigInState.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 02/07/24.
//

import Foundation

enum SigInState {
    case none
    case loading
    case goToHome
    case error(String)
}

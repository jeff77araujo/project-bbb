//
//  ProfileState.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 19/08/24.
//

import Foundation

enum ProfileState: Equatable {
    static func == (lhs: ProfileState, rhs: ProfileState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    
    case loading
    case success(UserResponse)
    case error(String)
}

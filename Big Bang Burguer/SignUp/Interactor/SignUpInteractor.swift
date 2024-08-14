//
//  SignUpInteractor.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 24/07/24.
//

import Foundation

class SignUpInteractor {
    
    private let remote: SignUpRemoteDataSource = .shared
    
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void) {
        remote.createUser(request: request, completion: completion)
    }
}

//
//  SignInInteractor.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 24/07/24.
//

import Foundation

class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void) {
        remote.login(request: request) { response, error in
            guard let response else { return }
            
            let userAuth = UserAuth(accessToken: response.accessToken,
                                    refreshToken: response.refreshToken,
                                    expiresSeconds: Int(Date().timeIntervalSince1970) + response.expiresSeconds,
                                    tokenType: response.tokenType)
            
            self.local.insertUserAuth(userAuth: userAuth )
            
            completion(response, error)
        }
    }

}

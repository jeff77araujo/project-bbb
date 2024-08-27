//
//  SplashInteractor.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 25/07/24.
//

import Foundation

class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SplashRequest, completion: @escaping (SignInResponse?, Bool?) -> Void) {
        remote.login(request: request) { response, error in
            guard let response else { return }
            
            let userAuth = UserAuth(accessToken: response.accessToken,
                                    refreshToken: response.refreshToken,
                                    expiresSeconds: Int(Date().timeIntervalSince1970) + response.expiresSeconds,
                                    tokenType: response.tokenType)
            
            self.local.insertUserAuth(userAuth: userAuth)
            
            completion(response, error)
        }
    }
}

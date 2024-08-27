//
//  SplashRemoteDataSource.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 25/07/24.
//

import Foundation

class SplashRemoteDataSource {
    
    static let shared = SplashRemoteDataSource()
    
    func login(request: SplashRequest, completion: @escaping (SignInResponse?, Bool?) -> Void) {
        WebService.shared.call(path: .refreshToken, body: request, method: .put) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                let response = try? JSONDecoder().decode(SignInResponse .self, from: data)
                completion(response, false)
                break
                
            case .failure(_,_):
                completion(nil, true)
                break 
            }
        }
    }
}

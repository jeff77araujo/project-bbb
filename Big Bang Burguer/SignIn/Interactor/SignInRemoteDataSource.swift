//
//  SignInRemoteDataSource.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 24/07/24.
//

import Foundation

class SignInRemoteDataSource {
    
    static let shared = SignInRemoteDataSource()
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void) {
        WebService.shared.call(path: .login, body: request, method: .post) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
                
            case .failure(let error, let data):
                guard let data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                default:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
                break
            }
        }
    }
}

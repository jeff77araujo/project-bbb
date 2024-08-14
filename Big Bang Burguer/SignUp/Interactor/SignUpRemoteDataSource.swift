//
//  SignUpRemoteDataSource.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 24/07/24.
//

import Foundation

class SignUpRemoteDataSource {
    static let shared = SignUpRemoteDataSource()
    
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void) {
        WebService.shared.call(path: .createUser, body: request, method: .post) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                completion(true, nil)
                break
                
            case .failure(let error, let data):
                guard let data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                    
                case .badRequest:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                    completion(nil, response?.detail)
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

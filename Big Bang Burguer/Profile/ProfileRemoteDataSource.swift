//
//  ProfileRemoteDataSource.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 19/08/24.
//

import Foundation

class ProfileRemoteDataSource {
    
    static let shared = ProfileRemoteDataSource()
    
    func fetch(completion: @escaping (UserResponse?, String?) -> Void) {
        
        WebService.shared.call(path: .me, body: Optional<FeedRequest>.none, method: .get) { result in
            
            switch result {
            case .success(let data):
                guard let data else { return }
                let response = try? JSONDecoder().decode(UserResponse.self, from: data)
                completion(response, nil)
                break
                
            case .failure(let error, let data):
                guard let data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                    
                case .internalError:
                    completion(nil, String(data: data, encoding: .utf8))
                    break
                    
                default:
                    let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
                
                break
            }
        }
    }
}

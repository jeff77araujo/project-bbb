//
//  CouponRemoteDataSource.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 20/08/24.
//

import Foundation

class CouponRemoteDataSource {
    
    static let shared = CouponRemoteDataSource()
    
    func fetchCoupons(completion: @escaping (UserResponse?, String?) -> Void) {
        
        WebService.shared.call(path: .coupons, body: Optional<FeedRequest>.none, method: .get) { result in
            
            switch result {
            case .success(let data):
                guard let data else { return }
                let response = try? JSONDecoder().decode(UserResponse.self, from: data)
                print("CouponRemoteDataSource.fetchCoupons: \(String(describing: response))")
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
                    let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
                
                break
            }
        }
    }
}

//
//  FeedRemoteDataSource.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 30/07/24.
//

import Foundation

class FeedRemoteDataSource {
    
    static let shared = FeedRemoteDataSource()
    
    func fetch(completion: @escaping (FeedResponse?, String?) -> Void) {
        WebService.shared.call(path: .feed, body: Optional<FeedRequest>.none, method: .get) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                let response = try? JSONDecoder().decode(FeedResponse.self, from: data)
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
    
    func fetchHighlight(completion: @escaping (HighlightResponse?, String?) -> Void) {
        WebService.shared.call(path: .highlight, body: Optional<FeedRequest>.none, method: .get) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                let response = try? JSONDecoder().decode(HighlightResponse.self, from: data)
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

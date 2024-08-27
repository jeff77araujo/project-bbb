//
//  WebService.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 18/07/24.
//

import Foundation

class WebService {
    static let shared = WebService()
    
    static let apiKey = "820939f7-0db8-4c02-b08e-ddcf90442dba"
    static let baseURL = "https://hades.tiagoaguiar.co/kingburguer"
    
    private func completeUrl(path: String) -> URLRequest? {
        let endpoint = "\(WebService.baseURL)\(path)"
        guard let url = URL(string: endpoint) else { return nil }
        return URLRequest(url: url)
    }
    
    // MARK: - CALL 1
    func  call(path: String,
               method: Method,
               completion: @escaping (Result) -> Void) {
        
        makeRequest(path: path, 
                    body: nil,
                    method: method,
                    completion: completion
        )
    }
    
    // MARK: - CALL 2
    func  call<T: Encodable>(path: Endpoint,
                             body: T?,
                             method: Method,
                             completion: @escaping (Result) -> Void) {
        
        makeRequest(path: path.rawValue, 
                    body: body,
                    method: method,
                    completion: completion
        )
    }
    
    // MARK: - Make Request
    private func  makeRequest(path: String,
                              body: Encodable?,
                              method: Method,
                              completion: @escaping (Result) -> Void) {
        
        guard var request = completeUrl(path: path) else { return }
        
        request.httpMethod = method.rawValue.uppercased()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(WebService.apiKey, forHTTPHeaderField: "x-secret-key")
        
        if let body = body {
            let jsonRequest = try? JSONEncoder().encode(body)
            request.httpBody = jsonRequest
        }
        
        if let accessToken = LocalDataSource.shared.getUserAuth()?.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("------------------------\n\n")
            print("WebService.makeRequest: \(String(describing: response))")
            
            if let error = error {
                completion(.failure(.internalError, error.localizedDescription.data(using: .utf8)))
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    completion(.success(data))
                    break
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 401:
                    completion(.failure(.unauthorized, data))
                    break
                case 404:
                    completion(.failure(.notFound, data))
                    break
                case 500:
                    completion(.failure(.internalError, data))
                    break
                default:
                    completion(.failure(.unknown, data))
                    break
                }
            }
        }
        task.resume()
    }
}

// MARK: - ENUM'S
extension WebService {
    enum Endpoint: String {
        case createUser = "/users"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case feed = "/feed"
        case highlight = "/highlight"
        case productDetail = "/products/%d"
        case coupon = "/products/%d/coupon"
        case me = "/users/me"
        case coupons = "/coupons"
    }
    
    enum Method: String {
        case post
        case put
        case get
        case delete
    }
    
    enum NetworkError {
        case badRequest
        case unauthorized
        case notFound
        case internalError
        case unknown
    }
    
    enum Result {
        case success(Data?)
        case failure(NetworkError, Data?)
    }
}

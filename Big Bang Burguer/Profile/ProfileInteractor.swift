//
//  ProfileInteractor.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 19/08/24.
//

import Foundation

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(completion: @escaping (UserResponse?, String?) -> Void) {
        return remote.fetch(completion: completion)
    }
}

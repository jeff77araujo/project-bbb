//
//  ProductDetailState.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 07/08/24.
//

import Foundation

enum ProductDetailState {
    case loading
    case success(ProductResponse)
    case error(String)
}

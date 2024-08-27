//
//  Double.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 31/07/24.
//

import Foundation

extension Double {
    func decimalNumbers() -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "PT-BR")

        return formatter.string(from: self as NSNumber)
    }
}


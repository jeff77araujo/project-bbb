//
//  Date.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 23/08/24.
//

import Foundation

extension Date {
    func toString(dateFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
}

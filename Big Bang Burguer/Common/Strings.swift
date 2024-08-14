//
//  Strings.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 14/07/24.
//

import Foundation

extension String {
    
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
// MARK: Metodo para retirar todos os caracteres que não sejam números, e junto tudo numa unica string
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func charAtIndex(index: Int) -> Character? {
        var indexCurrent = 0
        for char in self {
            if index == indexCurrent {
                return char
            }
            indexCurrent += 1
        }
        return nil
    }
}

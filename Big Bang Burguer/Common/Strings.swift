//
//  Strings.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 14/07/24.
//

import Foundation

// MARK: - VALIDADOR DE EMAIL
extension String {
    func isEmail() -> Bool {
        // Expressão regular revisada e simplificada
        let regEx = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
        
        do {
            let regex = try NSRegularExpression(pattern: regEx, options: [.caseInsensitive])
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) != nil
        } catch {
            return false
        }
    }
}

// MARK: - APENAS NUMEROS
extension String {
    // Método para remover todos os caracteres que não sejam números
    var onlyNumbers: String {
        return self.filter { $0.isNumber }
    }
}

// MARK: - GET INDEX
extension String {
    // Acesso a um caractere no índice de maneira mais segura
    func charAtIndex(at index: Int) -> Character? {
        guard index >= 0 && index < self.count else { return nil }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

// MARK: - FORMATADOR DE DATA
extension String {
    func toDate(dateFormat: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
                
        return dateFormatter.date(from: self)

    }
}

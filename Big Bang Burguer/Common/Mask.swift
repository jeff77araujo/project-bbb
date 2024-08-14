//
//  Mask.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 17/07/24.
//

import Foundation
import UIKit

class Mask {
    private let mask: String
    var oldString = ""
    
    init(mask: String) {
        self.mask = mask
    }
    
    private func replaceChars(value: String) -> String {
        return value.replacingOccurrences(of: ".", with: "")
                    .replacingOccurrences(of: "-", with: "")
                    .replacingOccurrences(of: "/", with: "")
                    .replacingOccurrences(of: " ", with: "")
    }
    
    func process(value: String) -> String? {
        if value.count > mask.count {
            return String(value.dropLast())
        }
        
        let str = replaceChars(value: value)
        let isDeleting = str <= oldString
        oldString = str
        
        var result = ""
        var i = 0
        for char in mask {
            if char != "#" {
                if isDeleting {
                    continue
                }
                result += String(char)
            } else {
                guard let character = str.charAtIndex(index: i) else { break }
                
                result += String(character)
                i += 1
            }
        }
        return result
    }
}

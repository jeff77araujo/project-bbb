//
//  KeyboardHandle.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 21/08/24.
//

import UIKit

class KeyboardHandle {
    
    let listener: (Bool, CGFloat) -> Void
    
    init(listener: @escaping (Bool, CGFloat) -> Void) {
        self.listener = listener
    }
    
    @objc func onKeyboardNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let isVisible = notification.name == UIResponder.keyboardWillShowNotification
        let key = isVisible ? UIResponder.keyboardFrameEndUserInfoKey : UIResponder.keyboardFrameBeginUserInfoKey
        
        guard let keyboardFrameValue = userInfo[key] as? NSValue else { return }
        let keyboardHeight = keyboardFrameValue.cgRectValue.height
        
        listener(isVisible, keyboardHeight)
    }
}

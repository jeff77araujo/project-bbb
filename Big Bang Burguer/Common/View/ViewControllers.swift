//
//  ViewControllers.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 21/08/24.
//

import UIKit

extension UIViewController {
    func configureKeyboard(handle: KeyboardHandle) {
        // Observador que será disparado baseado no evento do teclado: quando ele aparece ou desaparece
        NotificationCenter.default.addObserver(handle,
                                               selector: #selector(handle.onKeyboardNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(handle,
                                               selector: #selector(handle.onKeyboardNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    func configureDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func alert(message: String, onClick: (() -> Void)? = nil ) {
        let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            onClick?()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  Alert.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 14/08/24.
//

import UIKit

struct Alert {
    let title: String
    let message: String
    var buttonTitle: String = "OK"
    var handler: (() -> Void)?
    
    func show(on viewController: UIViewController) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            self.handler?()
        }
        
        alertController.addAction(action)

        viewController.present(alertController, animated: true)
    }
    
    static func message(on viewController: UIViewController, title: String, message: String, buttonTitle: String = "OK", handler: (() -> Void)? = nil) {
        Alert(title: title, message: message, buttonTitle: buttonTitle, handler: handler).show(on: viewController)
    }

}

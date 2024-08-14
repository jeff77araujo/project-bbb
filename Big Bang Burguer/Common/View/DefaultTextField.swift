//
//  DefaultTextField.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 09/07/24.
//

import Foundation
import UIKit

protocol TextFieldDelegate: UITextFieldDelegate {
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String)
}

class DefaultTextField: UIView {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()    
    
    lazy var errorMessage: UILabel = {
        let text = UILabel()
        text.textColor = .red
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var maskField: Mask?
    
    var bitmask = 0
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var failure: ( () -> Bool )?
    
    var error: String?
    
    var delegate: TextFieldDelegate? {
        willSet {
            textField.delegate = newValue
        }
    }
    
    var text: String? {
        get {
            return textField.text
        }
    }
    
    var keyboard: UIKeyboardType? {
        willSet {
            if newValue == .emailAddress {
                textField.autocapitalizationType = .none
            }
            textField.keyboardType = newValue ?? .default
        }
    }
    
    var secureTextEntry: Bool = false {
        willSet {
            textField.isSecureTextEntry = newValue
            textField.textContentType = .oneTimeCode
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet {
            textField.returnKeyType = newValue
        }
    }
    
    var placeholder: String? {
        willSet {
            textField.placeholder = newValue
        }
    }
    
    override var tintColor: UIColor? {
        willSet {
            textField.tintColor = newValue
        }
    }
    
    override var backgroundColor: UIColor? {
        willSet {
            textField.backgroundColor = newValue
        }
    }
    
    override var tag: Int {
        willSet {
            super.tag = newValue
            textField.tag = newValue
        }
    }
    
    var border: Bool? {
        willSet {
            textField.layer.cornerRadius = 15
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.clipsToBounds = true
            textField.borderStyle = .roundedRect
        }
    }
    
    func gainFocus() {
        textField.becomeFirstResponder()
    }
    
    var heightconstraints: NSLayoutConstraint!
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        
        if let mask = maskField {
            if let res = mask.process(value: textField.text ?? "") {
                textField.text = res
            }
        }
        
        guard let failure else { return }
        
        if let error = error {
            if failure() {
                errorMessage.text = error
                errorMessage.isHidden = false
                delegate?.textFieldDidChanged(isValid: false, bitmask: bitmask, text: textField.text ?? "")
            } else {
                errorMessage.text = ""
                errorMessage.isHidden = true
                delegate?.textFieldDidChanged(isValid: true, bitmask: bitmask, text: textField.text ?? "")
            }
        }
        layoutIfNeeded()
    }
    
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        addSubview(errorMessage)
        
        let constraints = [
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            errorMessage.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            errorMessage.topAnchor.constraint(equalTo: textField.bottomAnchor),
            errorMessage.heightAnchor.constraint(equalToConstant: 20),
        ]
        heightconstraints = heightAnchor.constraint(equalToConstant: 70)
        heightconstraints.isActive = true
        
        NSLayoutConstraint.activate(constraints)
    }
}

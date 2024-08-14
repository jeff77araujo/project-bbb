//
//  SignInViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 01/07/24.
//

import Foundation
import UIKit

enum SignInForm: Int {
    case email = 0x1
    case password = 0x2
}

class SignInViewController: UIViewController {
    
    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var email: DefaultTextField = {
        let email = DefaultTextField()
        email.placeholder = "Digite o seu e-mail"
        email.backgroundColor = .systemGray5
        email.returnKeyType = .next
        email.border = true
        email.delegate = self
        email.keyboard = .emailAddress
//        email.failure = validation
        email.bitmask = SignInForm.email.rawValue
        email.error = "E-mail inválido"
        email.failure = {
            return !(email.text?.isEmail() ?? false)
        }
        return email
    }()
    
    // MARK: - referencia tradicional da linha 38
    func validation() -> Bool {
        return !(email.text?.isEmail() ?? false)
    }
    
    lazy var password: DefaultTextField = {
        let password = DefaultTextField()
        password.placeholder = "Digite a sua senha"
        password.backgroundColor = .systemGray5
        password.returnKeyType = .done
        password.secureTextEntry = true
        password.border = true
        password.delegate = self
        password.keyboard = .default
        password.bitmask = SignInForm.password.rawValue
        password.error = "Senha deve ter no mínimo 6 caracteres"
        password.failure = {
            return password.text!.count < 6
        }
        return password
    }()
    
    lazy var enterButton: LoadingButton = {
        let enter = LoadingButton()
        enter.title = "Acessar"
        enter.titleColor = .black
        enter.border = true
        enter.enable(false)
        enter.addTarget(self, action: #selector(enterDidTap))
        return enter
    }()
    
    lazy var registerButton: LoadingButton = {
        let register = LoadingButton()
        register.title = "Clique aqui para criar uma conta"
        register.titleColor = .lightGray
        register.backgroundColor = .systemBackground
        register.startLoading(false)
        register.addTarget(self, action: #selector(registerDidTap))
        return register
    }()
    
    @objc func enterDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
    
    @objc func registerDidTap(_ sender: UIButton) {
        viewModel?.goToSignUp()
    }
    
    var viewModel: SignInViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult = 0
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "LOGIN"
        createViews()
        
        // Observador que será disparado baseado no evento do teclado: quando ele aparece ou desaparece
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func onKeyboardNotification(_ notification: Notification) {
        let visible = notification.name == UIResponder.keyboardWillShowNotification
        
        let keyboardFrame = visible
        ? UIResponder.keyboardFrameEndUserInfoKey
        : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue {
            onKeyboardChanged(visible, height: keyboardSize.height)
        }
    }
    
    func onKeyboardChanged(_ visible: Bool, height: CGFloat) {
        if (!visible) {
            scroll.contentInset = .zero
            scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            scroll.contentInset = contentInsets
            scroll.scrollIndicatorInsets = contentInsets
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func viewModelDidChanged(state: SigInState) {
        switch(state) {
        case .none:
            break
        case .loading:
            enterButton.startLoading(true)
            break
        case .goToHome:
            enterButton.startLoading(false)
            viewModel?.goToHome()
        case .error(let message):
            enterButton.startLoading(false)
            alertMessage(msg: message)
            print("ERRORRRRR: \(message)")
            break
        }
    }
    
    func alertMessage(msg: String) {
        let alert = UIAlertController(title: "Ops!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension SignInViewController {
    func createViews() {
        
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(enterButton)
        view.addSubview(registerButton)
        
        let constraints = [
            email.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            email.heightAnchor.constraint(equalToConstant: 50),
            
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            enterButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 50),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            registerButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension SignInViewController: TextFieldDelegate {
    
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            bitmaskResult = bitmaskResult | bitmask
        } else {
            bitmaskResult = bitmaskResult & ~bitmask
        }
        
        let validated = (SignInForm.email.rawValue & bitmaskResult != 0)
                    && (SignInForm.password.rawValue & bitmaskResult != 0)
        
        enterButton.enable(validated)
        
        if bitmask == SignInForm.email.rawValue {
            viewModel?.email = text
        } else if bitmask == SignInForm.password.rawValue {
            viewModel?.password = text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            viewModel?.send()
        } else {
            password.gainFocus()
        }
        return false
    }
}

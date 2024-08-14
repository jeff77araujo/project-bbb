//
//  SignUpViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 02/07/24.
//

import Foundation
import UIKit

enum SignUpForm: Int {
    case name       = 0x1
    case email      = 0x2
    case password   = 0x4
    case document   = 0x8
    case birthday   = 0x10
}

class SignUpViewController: UIViewController {
    
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
    
    lazy var name: DefaultTextField = {
        let name = DefaultTextField()
        name.placeholder = "Digite o seu nome"
        name.backgroundColor = .systemGray5
        name.returnKeyType = .next
        name.tag = 1
        name.bitmask = SignUpForm.name.rawValue
        name.border = true
        name.delegate = self
        name.keyboard = .default
        name.error = "Nome muito curto"
        name.failure = {
            return (name.text!.count < 3)
        }
        return name
    }()
    
    lazy var email: DefaultTextField = {
        let email = DefaultTextField()
        email.placeholder = "Digite um e-mail"
        email.backgroundColor = .systemGray5
        email.returnKeyType = .next
        email.tag = 2
        email.bitmask = SignUpForm.email.rawValue
        email.border = true
        email.delegate = self
        email.keyboard = .emailAddress
        email.error = "E-mail inválido"
        email.failure = {
            return !(email.text?.isEmail() ?? false)
        }
        return email
    }()
    
    lazy var password: DefaultTextField = {
        let password = DefaultTextField()
        password.placeholder = "Crie uma sua senha"
        password.backgroundColor = .systemGray5
        password.returnKeyType = .next
        password.secureTextEntry = true
        password.tag = 3
        password.bitmask = SignUpForm.password.rawValue
        password.border = true
        password.delegate = self
        password.secureTextEntry = true
        password.error = "Senha deve ter no mínimo 6 caracteres"
        password.failure = {
            return password.text!.count < 6
        }
        return password
    }()
    
    lazy var document: DefaultTextField = {
        let cpf = DefaultTextField()
        cpf.placeholder = "Digite o seu CPF"
        cpf.backgroundColor = .systemGray5
        cpf.returnKeyType = .next
        cpf.tag = 4
        cpf.bitmask = SignUpForm.document.rawValue
        cpf.border = true
        cpf.delegate = self
        cpf.maskField = Mask(mask: "###.###.###-##")
        cpf.keyboard = .numberPad
        cpf.error = "CPF inválido"
        cpf.failure = {
            return cpf.text!.count != 14
        }
        return cpf
    }()
    
    lazy var birthDay: DefaultTextField = {
        let birthDay = DefaultTextField()
        birthDay.placeholder = "Digite a sua data de nascimento"
        birthDay.backgroundColor = .systemGray5
        birthDay.returnKeyType = .done
        birthDay.tag = 5
        birthDay.bitmask = SignUpForm.birthday.rawValue
        birthDay.border = true
        birthDay.delegate = self
        birthDay.maskField = Mask(mask: "##/##/####")
        birthDay.keyboard = .numberPad
        birthDay.error = "Data não existe"
        birthDay.failure = {
            let invalidCount = birthDay.text!.count != 10
            let dt = DateFormatter()
            dt.locale = Locale(identifier: "en_US_POSIX")
            dt.dateFormat = "dd/MM/yyyy"
            
            let date = dt.date(from: birthDay.text ?? "")
            let invalidDate = date == nil
            
            return invalidDate || invalidCount
        }
        return birthDay
    }()
    
    lazy var createButton: LoadingButton = {
        let create = LoadingButton()
        create.title = "Criar conta"
        create.titleColor = .black
        create.border = true
        create.enable(false)
//        create.backgroundColor = .systemYellow
        create.addTarget(self, action: #selector(registerDidTap))
        return create
    }()
    
    @objc func registerDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
    
    var viewModel: SignUpViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "CADASTRO"
        createViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension SignUpViewController {
    func createViews() {
        
        view.addSubview(name)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(document)
        view.addSubview(birthDay)
        view.addSubview(createButton)
        
        let constraints = [
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            name.heightAnchor.constraint(equalToConstant: 50),
            
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            email.heightAnchor.constraint(equalToConstant: 50),
            
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            document.leadingAnchor.constraint(equalTo: password.leadingAnchor),
            document.trailingAnchor.constraint(equalTo: password.trailingAnchor),
            document.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            document.heightAnchor.constraint(equalToConstant: 50),
            
            birthDay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            birthDay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            birthDay.topAnchor.constraint(equalTo: document.bottomAnchor, constant: 20),
            birthDay.heightAnchor.constraint(equalToConstant: 50),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            createButton.topAnchor.constraint(equalTo: birthDay.bottomAnchor, constant: 40),
            createButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState) {
        switch(state) {
        case .none:
            break
        case .loading:
            createButton.startLoading(true)
            break
        case .goToLogin:
            createButton.startLoading(false)
            alertMessage(title: "Bem vindo!", msg: "Usúario cadastrado com sucesso", true)
//            viewModel?.goToLogin()
        case .error(let message):
            createButton.startLoading(false)
            alertMessage(title: "Ops!", msg: message, false)
            break
        }
    }
    
    private func alertMessage(title: String, msg: String, _ isCreated: Bool?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if isCreated ?? false {
                self.viewModel?.goToLogin()
            }
        }))
        self.present(alert, animated: true)
    }
}

extension SignUpViewController: TextFieldDelegate {
    
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            bitmaskResult = bitmaskResult | bitmask
        } else {
            bitmaskResult = bitmaskResult & ~bitmask
        }
        
        let validated = (SignUpForm.name.rawValue & bitmaskResult != 0)
                        && (SignUpForm.email.rawValue & bitmaskResult != 0)
                        && (SignUpForm.password.rawValue & bitmaskResult != 0)
                        && (SignUpForm.document.rawValue & bitmaskResult != 0)
                        && (SignUpForm.birthday.rawValue & bitmaskResult != 0)
        
        createButton.enable(validated)
        
        if bitmask == SignUpForm.name.rawValue {
            viewModel?.name = text
        } else if bitmask == SignUpForm.email.rawValue {
            viewModel?.email = text
        } else if bitmask == SignUpForm.password.rawValue {
            viewModel?.password = text
        } else if bitmask == SignUpForm.document.rawValue {
            viewModel?.document = text
        } else if bitmask == SignUpForm.birthday.rawValue {
            viewModel?.birthday = text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            print(".done")
            return false
        }

        let nextTag = textField.tag + 1
        let component = view.findViewByTag(tag: nextTag) as? DefaultTextField
        if (component != nil) {
            component?.gainFocus()
            print("deu certo")
        } else {
            view.endEditing(true)
            print("deu ruim")
        }
        
        return false
    }
}

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}

//
//  LoadingButton.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 09/07/24.
//

import Foundation
import UIKit

class LoadingButton: UIView {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let progress: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    var title: String? {
        willSet {
            button.setTitle(newValue, for: .normal)
        }
    }
    
    var titleColor: UIColor? {
        willSet {
            button.setTitleColor(newValue, for: .normal)
        }
    }
    
    override var backgroundColor: UIColor? {
        willSet {
            button.backgroundColor = newValue
        }
    }
    
    var border: Bool? {
        willSet {
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 3
            button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
//            button.layer.masksToBounds = true
//            button.clipsToBounds = true
            button.backgroundColor = .systemYellow
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addTarget(_ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func enable(_ isEnable: Bool) {
        button.isEnabled = isEnable
        if isEnable {
            alpha = 1
        } else {
            alpha = 0.5
        }
    }
    
    func startLoading(_ loading: Bool) {
        button.isEnabled = !loading
        if loading {
            button.setTitle("", for: .normal)
            progress.startAnimating()
            alpha = 0.5
        } else {
            button.setTitle(title, for: .normal)
            progress.stopAnimating()
            alpha = 1.0
        }
    }
    
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        addSubview(progress)
        
        let constraints = [
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            progress.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            progress.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            progress.topAnchor.constraint(equalTo: topAnchor),
            progress.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

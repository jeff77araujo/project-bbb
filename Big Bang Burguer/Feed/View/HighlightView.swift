//
//  HighlightView.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 10/07/24.
//

import UIKit

protocol HighlightViewDelegate {
    func highlightSelected(productId: Int)
}

class HighlightView: UIView {
    
    var delegate: HighlightViewDelegate?
    var productId: Int?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .systemOrange
        return image
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resgatar cupom", for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped() {
        guard let productId else { return }
        delegate?.highlightSelected(productId: productId)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        
        addGradient()
        createViews()
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func createViews() {
        addSubview(moreButton)
        
        let constraints = [
            moreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

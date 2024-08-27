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
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("Resgate essa promoção", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
//        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.addTarget(HighlightView.self, action: #selector(buttonTapped), for: .touchUpInside)
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
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            moreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

//
//  ProductDetailViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 01/08/24.
//

import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {
    
    var id: Int?
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let progress: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.backgroundColor = .systemBackground
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let container: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        return stack
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemBackground
        return image
    }()
    
    let containerPrice: UIView = {
        let price = UIView()
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .center
        name.textColor = .red
        name.font = .systemFont(ofSize: 20)
        return name
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textAlignment = .center
        price.textColor = .white
        price.backgroundColor = .red
        price.font = .systemFont(ofSize: 18)
        price.layer.cornerRadius = 10
        price.clipsToBounds = true
        return price
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton(configuration: .plain())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Resgatar cupom", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemRed
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        button.addTarget(self, action: #selector(couponTapped), for: .touchUpInside)
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.textAlignment = .left
        description.numberOfLines = 0
        description.sizeToFit()
        description.font = .systemFont(ofSize: 16)
        return description
    }()
    
    // MARK: - VIEWMODEL
    var viewModel: ProductDetailViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Cupom"
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel?.fetch(id: id ?? 0)
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        view.addSubview(button)
        view.addSubview(progress)
        
        scrollView.addSubview(container)
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(containerPrice)
        container.addArrangedSubview(descriptionLabel)
        containerPrice.addSubview(nameLabel)
        containerPrice.addSubview(priceLabel)
        
        let sl = scrollView.contentLayoutGuide
        let constraints = [
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progress.topAnchor.constraint(equalTo: view.topAnchor),
            progress.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.topAnchor.constraint(equalTo: sl.topAnchor),
            container.leadingAnchor.constraint(equalTo: sl.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: sl.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: sl.bottomAnchor, constant: -40),
            
            containerPrice.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.leadingAnchor.constraint(equalTo: containerPrice.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: containerPrice.topAnchor, constant: 10),
            
            priceLabel.trailingAnchor.constraint(equalTo: containerPrice.trailingAnchor, constant: -20),
            priceLabel.topAnchor.constraint(equalTo: containerPrice.topAnchor, constant: 10),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Extension Delegate
extension ProductDetailViewController: ProductDetailViewModelDelegate {
    
    @objc func couponTapped() {
        guard let id else { return }
        viewModel?.createCoupon(id: id)
    }

    func viewModelDidChanged(state: ProductDetailState) {
        switch(state) {
        case .loading:
            progress.startAnimating()
            break
            
        case .success(let response):
            progress.stopAnimating()
            
            guard let price = response.price.decimalNumbers() else { return }
            
            self.priceLabel.text = "\(price)"
            self.nameLabel.text = response.name
            self.descriptionLabel.text = response.description
            
            if let url = URL(string: response.pictureUrl) {
                self.imageView.sd_setImage(with: url)
            }
            break
            
        case .successCoupon(let response):
            progress.stopAnimating()
            Alert(title: "Cupom gerado", message: response.coupon).show(on: self)
            break
            
        case .error(let message):
            progress.stopAnimating()
            alert(message: message)
            break
        }
    }
}

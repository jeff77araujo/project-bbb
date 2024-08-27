//
//  CouponViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 10/07/24.
//

import UIKit

class CouponViewController: UITableViewController {
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        tabBarItem.image = UIImage(systemName: "ticket")
        tabBarItem?.title = "Cupons"
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var viewModel: CouponViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if viewModel?.state == .loading {
            viewModel?.fetchCoupons()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension CouponViewController {
    private func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        navigationItem.title = "Cupons"
    }
}

extension CouponViewController: CouponViewModelDelegate {
    func viewModelDidChanged(state: ProfileState) {
        switch(state) {
        case .loading:
            break
            
        case .success(let response):
            print("CouponViewController.viewModelDidChanged: \(response)")
            break
            
        case .error(let message):
//            Alert(title: "Erro na Request", message: message).show(on: self)
            alert(message: message)
            break
        }
    }
}

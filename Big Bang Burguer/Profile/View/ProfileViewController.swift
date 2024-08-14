//
//  ProfileViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 10/07/24.
//

import UIKit

class ProfileViewController: UIViewController {

    let test: UIView = {
        let v = UIView(frame: CGRect(x: 20, y: 100, width: 20, height: 20))
        v.backgroundColor = .systemGreen
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(test)
    }


}

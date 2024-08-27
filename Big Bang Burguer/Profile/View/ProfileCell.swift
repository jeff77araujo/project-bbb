//
//  ProfileCell.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 17/08/24.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    static let identifier = "ProfileCell"
    
    var data: (String, String)! {
        willSet {
            leftLabel.text = newValue.0
            rightLabel.text = newValue.1
        }
    }
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, mundo!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, world!"
        label.textAlignment = .right
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupContraints() {
        let constraints = [
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 10),
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            rightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

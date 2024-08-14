//
//  FeedCollectionViewCell.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 11/07/24.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeedCollectionViewCell"
    
    var product: ProductResponse? {
        willSet {
            if let url = URL(string: newValue?.pictureUrl ?? "") {
                imageView.sd_setImage(with: url)
            }
            if let name = newValue?.name {
                nameLabel.text = name
            }
            if let price = newValue?.price {
                priceLabel.text = price.decimalNumbers()
            }
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.textColor = .red
        name.font = .systemFont(ofSize: 14)
        name.text = "Error"
        return name
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.textAlignment = .center
        price.textColor = .white
        price.backgroundColor = .red
        price.font = .systemFont(ofSize: 15)
        
        price.layer.borderWidth = 1
        price.layer.masksToBounds = true
        price.layer.borderColor = UIColor.lightText.cgColor
        price.layer.cornerRadius = 5
        
        price.text = "Error"
        return price
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - 80)
        nameLabel.frame = CGRect(x: 0, y: bounds.size.height - 80, width: bounds.size.width, height: 28)
        priceLabel.frame = CGRect(x: 0, y: bounds.size.height - 50, width: bounds.size.width, height: 38)
//        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

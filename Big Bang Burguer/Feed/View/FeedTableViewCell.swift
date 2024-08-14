//
//  FeedTableViewCell.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 10/07/24.
//

import UIKit
import SDWebImage

protocol FeedCollectionViewDelegate {
    func itemSelected(productId: Int)
}

class FeedTableViewCell: UITableViewCell {
    static let identifier = "FeedTableViewCell"
    
    var products: [ProductResponse] = []
    var delegate: FeedCollectionViewDelegate?
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 220)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        
        return collection
    }()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func layoutSubviews() {
//        collectionView.frame = contentView.bounds
        collectionView.frame = CGRect(x: 5, y: 0, width: bounds.size.width - 5, height: bounds.size.height - 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CONFIG COLLECTION VIEW
extension FeedTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, 
                                                      for: indexPath) as! FeedCollectionViewCell

        cell.product = products[indexPath.row]
                
        return cell
    }
    // MARK: - Evento de clique dos itens
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemSelected(productId: products[indexPath.row].id)
    }
}

//
//  FeedViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 10/07/24.
//

import UIKit

class FeedViewController: UIViewController {
    
    var sections: [CategoryResponse] = []
    
    // MARK: - VIEWS
    private var headerView = HighlightView()
    
    private let progress: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.backgroundColor = .systemBackground
        progress.startAnimating()
        return progress
    }()
        
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        table.backgroundColor = .systemBackground
        return table
    }()
    
    // MARK: - VIEW MODEL
    var viewModel: FeedViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureComponents()
        configureNavBar()
        
        viewModel?.fetch()
        viewModel?.fetchHighlight()
    }
    
    override func viewDidLayoutSubviews() {
        homeFeedTable.frame = view.bounds
        progress.frame = view.bounds
    }
}

// MARK: - FUNCTIONS
extension FeedViewController {
    
    private func configureComponents() {
        
        view.addSubview(homeFeedTable)
        view.addSubview(progress)
        
        headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 220))
        headerView.delegate = self
        
        homeFeedTable.tableHeaderView = headerView
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    private func configureNavBar() {
        
        navigationController?.tabBarItem.image = UIImage(systemName: "house")
        navigationController?.title = "Home"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        navigationItem.title = "Produtos"
        
        var image = UIImage(named: "icon")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .done,
                                                           target: self,
                                                           action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "power"),
                            style: .done,
                            target: self,
                            action: #selector(testDidTap)
                           )
        ]
    }
    
    @objc func testDidTap(_ sender: UIBarButtonItem) {
        print("------------------------\n\n")
        print("alguem clicou")
    }
}

// MARK: - TABLEVIEW Config
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        var label = UILabel()
        if section == 0 {
            label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width, height: 40))
        } else {
            label = UILabel(frame: CGRect(x: 20, y: -10, width: tableView.bounds.width, height: 10))
        }
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.text = sections[section].name.uppercased()
        
        view.addSubview(label)
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        
        cell.products.append(contentsOf: sections[indexPath.section].products)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - Extension Delegate
extension FeedViewController: FeedViewModelDelegate, FeedCollectionViewDelegate, HighlightViewDelegate {
    
    func highlightSelected(productId: Int) {
        viewModel?.goToProductDetail(id: productId)
    }
    
    func itemSelected(productId: Int) {
        viewModel?.goToProductDetail(id: productId)
    }
    
    func viewModelDidChanged(state: FeedState) {
        switch(state) {
        case .loading:
            break
        case .success(let response):
            progress.stopAnimating()
            
            sections = response.categories
            homeFeedTable.reloadData()
            print("------------------------\n\n")
            print("FeedViewController-success")
            break
        case .successHighlight(let response):
            progress.stopAnimating()
            
            guard let url = URL(string: response.pictureUrl) else { break }
            headerView.imageView.sd_setImage(with: url)
            headerView.productId = response.id
            
            break
        case .error(let msg):
            progress.stopAnimating()
            homeFeedTable.reloadData()
            break
        }
    }
}

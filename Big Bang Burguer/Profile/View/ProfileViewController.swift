//
//  ProfileViewController.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 10/07/24.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    var data: [ (String, String) ] = []
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        tabBarItem.image = UIImage(systemName: "person.circle")
        tabBarItem?.title = "Perfil"
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - VIEWMODEL
    var viewModel: ProfileViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - VIEW DID APPEAR
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel?.state == .loading {
            viewModel?.fetch()
        }
        
    }
}

extension ProfileViewController {
    private func configure() {
        tableView.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        navigationItem.title = "Perfil"
    }
}

extension ProfileViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        
        cell.data = data[indexPath.row]
        cell.isUserInteractionEnabled = false
        
        return cell
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func viewModelDidChanged(state: ProfileState) {
        switch(state) {
        case .loading:
            break
            
        case .success(let response):
            guard let documentFormatted = Mask(mask: "###.###.###-##").process(value: response.document) else { return }
            guard let birthdayFormatted = response.birthday.toDate(dateFormat: "yyyy-MM-dd")?.toString(dateFormat: "dd/MM/yyyy") else { return }
            
            data.append( ("Identificador: ", "\(response.id)") )
            data.append( ("Nome: ", response.name) )
            data.append( ("E-mail: ", response.email) )
            data.append( ("Documento: ", documentFormatted) )
            data.append( ("Data de nascimento: ", birthdayFormatted) )
            tableView.reloadData()
            break
            
        case .error(let message):
//            Alert(title: "Erro na Request", message: message).show(on: self)
            alert(message: message)
            break
        }
    }
}

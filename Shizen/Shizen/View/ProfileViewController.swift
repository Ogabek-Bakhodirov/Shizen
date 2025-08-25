//
//  ProfileViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 03/02/25.
//

import UIKit


class ProfileViewController: UIViewControllerExtensions {
    
    let profileViewControllerDataBase: [ProfileViewControllerDataBase] = [
        ProfileViewControllerDataBase(icon: UIImage(systemName: "pencil") ?? UIImage(), title: "Ma’lumotni o’zgartirish"),
        ProfileViewControllerDataBase(icon: UIImage(systemName: "paintpalette") ?? UIImage(), title: "Theme"),
        ProfileViewControllerDataBase(icon: UIImage(systemName: "globe.asia.australia") ?? UIImage(), title: "Til"),
        ProfileViewControllerDataBase(icon: UIImage(systemName: "bubble.left.and.bubble.right") ?? UIImage(), title: "Yordam"),
    ]
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = UserModel.shared.getFullName()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = UserModel.shared.getNumber()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileViewCell.self, forCellReuseIdentifier: ProfileViewCell.cellName)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainBackgroundColor")
        NotificationCenter.default.addObserver(self, selector: #selector(userInfoUpdated), name: .userInfoUpdated, object: nil)
        setupSubviews()
    }
    
    func setupSubviews(){
    
        view.addSubview(usernameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(tableView)
        
        enableBackButton(ViewController: self)
        
        NSLayoutConstraint.activate([
            
            usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(148)),
            usernameLabel.heightAnchor.constraint(equalToConstant: universalHeight(19)),
            usernameLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalHeight(80)),
            usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalHeight(40)),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: universalHeight(10)),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: universalHeight(19)),
            phoneNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalHeight(40)),
            phoneNumberLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalHeight(80)),
            
            tableView.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: universalHeight(30)),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    @objc func userInfoUpdated(notification: Notification){
        usernameLabel.text = UserModel.shared.getFullName()
        phoneNumberLabel.text = UserModel.shared.getNumber()
    }

    deinit {
        NotificationCenter.default.removeObserver(self) // Cleanup observer
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewControllerDataBase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileViewCell(cellIconImage: profileViewControllerDataBase[indexPath.row].icon, cellNameString: profileViewControllerDataBase[indexPath.row].title)
        cell.backgroundColor = .clear
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        universalHeight(63)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openViewController(viewController: EditInfoViewController())
        } else if indexPath.row == 1 || indexPath.row == 2 {
            print(UserModel.shared.printAll())
            openViewController(viewController: NotReadyScreenViewController())
        } else if indexPath.row == 3 {
            openViewController(viewController: HelpViewController())
        }
    }
}

struct ProfileViewControllerDataBase{
    let icon: UIImage
    let title: String
}

extension ProfileViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

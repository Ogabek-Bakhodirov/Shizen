//
//  AwardDescriptionViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 08/03/25.
//

//import UIKit
//
//class AwardDescriptionViewController: UIViewController{
//    
//    let awardsStruct = UserAwardsListStruct(icon: "", title: "", description: "")
//    
//    private lazy var backButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage().getImage(.backArrowIcon), for: .normal)
//        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var backLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Orqaga"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .colorBlack
//        label.font = .systemFont(ofSize: 18, weight: .regular)
//        label.textAlignment = .left
//        label.isUserInteractionEnabled = true
//        return label
//    }()
//    
//    lazy var awardIconLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 130, weight: .regular)
//        label.textAlignment = .center
//        label.text = awardsStruct.icon //"🏆"
//        return label
//    }()
//    
//    lazy var awardTitleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 30, weight: .bold)
//        label.textAlignment = .center
//        label.textColor = .colorBlack
//        label.numberOfLines = 0
//        label.text = awardsStruct.title //"Deep Focus Master"
//        return label
//    }()
//    
//    lazy var awardDescriptionLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 16, weight: .regular)
//        label.textAlignment = .center
//        label.textColor = .colorBlack
//        label.numberOfLines = 0
//        label.text = awardsStruct.description
//        return label
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .mainBackgroundColor
//        setupSubviews()
//        
//        let backLabelTap = UITapGestureRecognizer(target: self, action: #selector(backLabalTapped(_:)))
//        backLabel.addGestureRecognizer(backLabelTap)
//    }
//    
//    func setupSubviews(){
//        view.addSubview(backButton)
//        view.addSubview(backLabel)
//        view.addSubview(awardIconLabel)
//        view.addSubview(awardTitleLabel)
//        view.addSubview(awardDescriptionLabel)
//        
//        NSLayoutConstraint.activate([
//            
//            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(68)),
//            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(10)),
//            backButton.widthAnchor.constraint(equalToConstant: universalWidth(20)),
//            backButton.heightAnchor.constraint(equalToConstant: universalHeight(20)),
//            
//            backLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(68)),
//            backLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor),
//            backLabel.widthAnchor.constraint(equalToConstant: universalWidth(81)),
//            backLabel.heightAnchor.constraint(equalToConstant: universalHeight(22)),
//            
//            awardIconLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(70)),
//            awardIconLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            awardIconLabel.widthAnchor.constraint(equalToConstant: universalWidth(135)),
//            awardIconLabel.heightAnchor.constraint(equalToConstant: universalHeight(135)),
//            
//            awardTitleLabel.topAnchor.constraint(equalTo: awardIconLabel.bottomAnchor, constant: universalHeight(13)),
//            awardTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            awardTitleLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(100)),
//            awardTitleLabel.heightAnchor.constraint(equalToConstant: universalHeight(72)),
//            
//            awardDescriptionLabel.topAnchor.constraint(equalTo: awardTitleLabel.bottomAnchor, constant: universalHeight(20)),
//            awardDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            awardDescriptionLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(100)),
//            awardDescriptionLabel.heightAnchor.constraint(equalToConstant: awardDescriptionLabel.getSelfSize(maxWidth: windowWidth - universalWidth(100)).height),
//
//        ])
//    }
//    
//    @objc func dismissViewController(){
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @objc func backLabalTapped(_ gestureRecognizer: UITapGestureRecognizer? = nil) {
//        dismissViewController()
//    }
//    
//    //MARK: - Makes safe area dark
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
//}

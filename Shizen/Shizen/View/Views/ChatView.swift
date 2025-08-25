////
////  ChatView.swift
////  Focus
////
////  Created by Ogabek Bakhodirov on 28/11/24.
////
//
//import UIKit
//
//class ChatView: UIView{
//    
//    var gotoappButtonClousure: (() -> Void)?
//    
//    var canOpenApp = true
//    
//    private lazy var appLogo: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(named: "AIAvatar")
//        image.contentMode = .scaleAspectFit
//        image.layer.cornerRadius = 18
//        image.clipsToBounds = true
//        return image
//    }()
//    
//    lazy var goToAppButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = canOpenApp ? UIColor.black : #colorLiteral(red: 0.8, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
//        button.setTitle("Ilovani ochish", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        if canOpenApp {
//            button.addTarget(self, action: #selector(gotoappButtonTapped), for: .touchUpInside)
//        }
//        return button
//    }()
//    
//    private lazy var focusAILabel: UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Focus AI"
//        label.textAlignment = .left
//        label.textColor = .black
//        label.font = .systemFont(ofSize: 18, weight: .semibold)
//        return label
//    }()
//    
//    private lazy var supportTimeLabel: UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "24/7 Xizmatingizda"
//        label.textAlignment = .left
//        label.textColor = UIColor(named: "LightTextColor")
//        label.font = .systemFont(ofSize: 16, weight: .medium)
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupSubviews()
//    }
//    
//    
//    
//    private func setupSubviews(){
//        
//        self.addSubview(appLogo)
//        self.addSubview(goToAppButton)
//        self.addSubview(focusAILabel)
//        self.addSubview(supportTimeLabel)
//        
//        NSLayoutConstraint.activate([
//            appLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(63)),
//            appLogo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(10)),
//            appLogo.widthAnchor.constraint(equalToConstant: universalWidth(37)),
//            appLogo.heightAnchor.constraint(equalToConstant: universalHeight(37)),
//            
//            goToAppButton.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(67)),
//            goToAppButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: universalWidth(-15)),
//            goToAppButton.widthAnchor.constraint(equalToConstant: universalWidth(130)),
//            goToAppButton.heightAnchor.constraint(equalToConstant: universalHeight(33)),
//            
//            focusAILabel.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(55)),
//            focusAILabel.leftAnchor.constraint(equalTo: appLogo.rightAnchor, constant: universalWidth(15)),
//            focusAILabel.widthAnchor.constraint(equalToConstant: universalWidth(100)),
//            focusAILabel.heightAnchor.constraint(equalToConstant: universalHeight(22)),
//            
//            supportTimeLabel.topAnchor.constraint(equalTo: focusAILabel.bottomAnchor, constant: universalHeight(4)),
//            supportTimeLabel.leftAnchor.constraint(equalTo: appLogo.rightAnchor, constant:  universalWidth(15)),
//            supportTimeLabel.widthAnchor.constraint(equalToConstant: universalWidth(150)),
//            supportTimeLabel.heightAnchor.constraint(equalToConstant: universalHeight(19)),
//            
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc func gotoappButtonTapped(){
//        gotoappButtonClousure?()
//    }
//    
//}

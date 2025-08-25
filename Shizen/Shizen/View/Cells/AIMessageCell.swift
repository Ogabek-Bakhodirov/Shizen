//
//  AIMessageCell.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 30/11/24.
//

import UIKit 

class AIMessageCell: UITableViewCell {
        
    private var labelSize: CGSize?
    
    private var chatMessage: String?
    
    private var font: UIFont?
    
        
    static let cellName = String(describing: AIMessageCell.self)
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view 
    }()
    
    private lazy var aiAvatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "AIAvatar")
        image.layer.cornerRadius = 37/2
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
        return image
    }()
    
    lazy var messageView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        if let labelSize = labelSize {
            view.layer.cornerRadius = (labelSize.height > 52) ?  20 : 10
        } else { view.layer.cornerRadius = 10 }
        
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.text = chatMessage
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    init(chatMessage: String, labelSize: CGSize, font: UIFont) {
        super.init(style: .default, reuseIdentifier: "AIMessageCell")
        setMessageLabelValues(chatMessage: chatMessage, labelSize: labelSize, font: font)
        setupSubviews()
    }
    
    func setMessageLabelValues(chatMessage: String, labelSize: CGSize, font: UIFont){
        self.chatMessage = chatMessage
        self.font = font
        self.labelSize = labelSize
    }
    
    func setupSubviews(){
        
        self.addSubview(mainView)
        mainView.addSubview(aiAvatarImageView)
        mainView.addSubview(messageView)
        messageView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            aiAvatarImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -7.5),
            aiAvatarImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 5),
            aiAvatarImageView.widthAnchor.constraint(equalToConstant: 37),
            aiAvatarImageView.heightAnchor.constraint(equalToConstant: 37),
            
            messageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -7.5),
            messageView.leftAnchor.constraint(equalTo: aiAvatarImageView.rightAnchor, constant: 5),
            messageView.widthAnchor.constraint(equalToConstant: (labelSize?.width ?? 10) + 30),
            messageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 7.5),  
            
            messageLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 15),
            messageLabel.leftAnchor.constraint(equalTo: messageView.leftAnchor, constant: 15),
            messageLabel.rightAnchor.constraint(equalTo: messageView.rightAnchor, constant: -15),
            messageLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -15),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

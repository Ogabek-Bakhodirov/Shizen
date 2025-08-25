//
//  UserMessageCell.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 30/11/24.
//

import UIKit

class UserMessageCell: UITableViewCell{
    
    private var labelSize: CGSize?
    
    private var chatMessage: String?
    
    private var font: UIFont?
        
    static let cellName = String(describing: UserMessageCell.self)
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view 
    }()
    
    lazy var messageView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1736698151, green: 0.3932626843, blue: 0.889757812, alpha: 1)        
        
        if let labelSize = labelSize {
            view.layer.cornerRadius = (labelSize.height > 52) ?  20 : 10
        } else { view.layer.cornerRadius = 10 }
        
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = #colorLiteral(red: 0.231372549, green: 0.3882352941, blue: 0.8588235294, alpha: 0.1)
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.text = chatMessage ?? ""
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    init(chatMessage: String, labelSize: CGSize, font: UIFont) {
        super.init(style: .default, reuseIdentifier: "UserMessageCell")
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
        mainView.addSubview(messageView)
        messageView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            messageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -7.5),
            messageView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
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

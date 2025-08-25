//
//  ForgotPasswordView.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 03/02/25.
//

import UIKit

class ForgotPasswordView: UIView {
    
    var rememberPasswordClouser: (() -> Void)?
    
    var sendButtonClouser: (() -> Void)?
    
    // MARK: - UI Elements
    
    private let focusAILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Focus AI"
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let appLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "AIAvatar")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 18
        image.clipsToBounds = true
        return image
    }()
    
    private let passwordRecoveryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Parolni tiklash"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = #colorLiteral(red: 0.4147184491, green: 0.4642122388, blue: 0.4990584254, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let recoveryHintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Yangi parol olish uchun telefon raqamingizni kiriting"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = #colorLiteral(red: 0.4147184491, green: 0.4642122388, blue: 0.4990584254, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let phoneNumberTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Telefon raqamingizni kiriting")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textFieldView.keyboardType = .phonePad
        return textField
    }()
    
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Yuborish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.addTarget(ForgotPasswordView.self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let remeberPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Parolni esladim", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(ForgotPasswordView.self, action: #selector(rememberPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
        let hideKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(dismissKeyboard))
        hideKeyboardTap.cancelsTouchesInView = false
        self.addGestureRecognizer(hideKeyboardTap)
    }
    
    
    
    private func setupSubviews(){
        self.backgroundColor = .clear
        
        
        self.addSubview(focusAILabel)
        self.addSubview(appLogo)
        self.addSubview(passwordRecoveryLabel)
        self.addSubview(recoveryHintLabel)
        self.addSubview(phoneNumberTextField)
        self.addSubview(sendButton)
        self.addSubview(remeberPasswordButton)
                
        NSLayoutConstraint.activate([
            
            focusAILabel.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(61)),
            focusAILabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(83)),
            focusAILabel.widthAnchor.constraint(equalToConstant: universalWidth(172)),
            focusAILabel.heightAnchor.constraint(equalToConstant: universalHeight(48)),
            
            appLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(61)),
            appLogo.leftAnchor.constraint(equalTo: focusAILabel.rightAnchor, constant: universalWidth(10)),
            appLogo.widthAnchor.constraint(equalToConstant: universalWidth(45)),
            appLogo.heightAnchor.constraint(equalToConstant: universalHeight(45)),
            
            passwordRecoveryLabel.topAnchor.constraint(equalTo: focusAILabel.bottomAnchor, constant: universalHeight(100)),
            passwordRecoveryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(20)),
            passwordRecoveryLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
            passwordRecoveryLabel.heightAnchor.constraint(equalToConstant: universalHeight(36)),
            
            recoveryHintLabel.topAnchor.constraint(equalTo: passwordRecoveryLabel.bottomAnchor, constant: universalHeight(30)),
            recoveryHintLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(20)),
            recoveryHintLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
            recoveryHintLabel.heightAnchor.constraint(equalToConstant: universalHeight(40)),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: recoveryHintLabel.bottomAnchor, constant: universalHeight(10)),
            phoneNumberTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(15)),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: universalWidth(70)),
            
            sendButton.heightAnchor.constraint(equalToConstant: universalHeight(54)),
            sendButton.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(104)),
            sendButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(52)),
            sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: universalHeight(-105)),
            
            remeberPasswordButton.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: universalHeight(15)),
            remeberPasswordButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            remeberPasswordButton.widthAnchor.constraint(equalToConstant: windowWidth),
            remeberPasswordButton.heightAnchor.constraint(equalToConstant: universalHeight(19))
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rememberPasswordTapped(){
        rememberPasswordClouser?()
        print("tapped rememberPasswordTapped")
    }
    
    @objc func sendButtonTapped(){
        sendButtonClouser?()
    }
    
    @objc func dismissKeyboard() {
            self.endEditing(true)
    }
}

//
//  RegistrationView.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 03/02/25.
//

import UIKit

class RegistrationView: UIView{
    
    var registerClouser: (() -> Void)?
    
    var loginClouser: (() -> Void)?
    
    var hideKeyboardClouser: (() -> Void)?

    
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
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hisob yaratish"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = #colorLiteral(red: 0.4147184491, green: 0.4642122388, blue: 0.4990584254, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let nameTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Ism")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let surnameTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Familiya")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Telefon Raqam")
        textField.textFieldView.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    let passwordTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Parol")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let minCharLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Minimal belgi soni 8 ta"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = #colorLiteral(red: 0.4147184491, green: 0.4642122388, blue: 0.4990584254, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ro‘yxatdan o‘tish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.addTarget(RegistrationView.self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let fullText = "Allaqachon hisob mavjud? Kirish"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // "Don't have an account?" ni kul rangga o'zgartirish
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: 24))
        
        // "Register" ni ko'k rangga o'zgartirish
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 24, length: 7))
        
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(RegistrationView.self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
        self.addSubview(registrationLabel)
        self.addSubview(nameTextField)
        self.addSubview(surnameTextField)
        self.addSubview(phoneTextField)
        self.addSubview(passwordTextField)
        self.addSubview(minCharLabel)
        self.addSubview(registerButton)
        self.addSubview(loginButton)
        

    
        
        NSLayoutConstraint.activate([
            
            focusAILabel.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(61)),
            focusAILabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(83)),
            focusAILabel.widthAnchor.constraint(equalToConstant: universalWidth(172)),
            focusAILabel.heightAnchor.constraint(equalToConstant: universalHeight(48)),
            
            appLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(61)),
            appLogo.leftAnchor.constraint(equalTo: focusAILabel.rightAnchor, constant: universalWidth(10)),
            appLogo.widthAnchor.constraint(equalToConstant: universalWidth(45)),
            appLogo.heightAnchor.constraint(equalToConstant: universalHeight(45)),
            
            registrationLabel.topAnchor.constraint(equalTo: focusAILabel.bottomAnchor, constant: universalHeight(55)),
            registrationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(20)),
            registrationLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
            registrationLabel.heightAnchor.constraint(equalToConstant: universalHeight(36)),
            
            nameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: universalHeight(17)),
            nameTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(15)),
            nameTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            nameTextField.heightAnchor.constraint(equalToConstant: universalHeight(70)),
            
            surnameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: universalHeight(90)),
            surnameTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(15)),
            surnameTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            surnameTextField.heightAnchor.constraint(equalToConstant: universalHeight(70)),
            
            phoneTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: universalHeight(5)),
            phoneTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(15)),
            phoneTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            phoneTextField.heightAnchor.constraint(equalToConstant: universalHeight(70)),
            
            passwordTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: universalHeight(5)),
            passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(15)),
            passwordTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            passwordTextField.heightAnchor.constraint(equalToConstant: universalHeight(70)),
            
            minCharLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: universalHeight(15)),
            minCharLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(20)),
            minCharLabel.widthAnchor.constraint(equalToConstant: universalWidth(200)),
            minCharLabel.heightAnchor.constraint(equalToConstant: universalHeight(17)),

            registerButton.heightAnchor.constraint(equalToConstant: universalHeight(54)),
            registerButton.widthAnchor.constraint(equalToConstant: universalWidth(289)),
            registerButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(52)),
            registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: universalHeight(-105)),
            
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: universalHeight(15)),
            loginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            loginButton.widthAnchor.constraint(equalToConstant: windowWidth),
            loginButton.heightAnchor.constraint(equalToConstant: universalHeight(19))
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func registerButtonTapped(){
        registerClouser?()
    }
    
    @objc func loginButtonTapped(){
        loginClouser?()
    }
    

    @objc func dismissKeyboard() {
            self.endEditing(true)
    }
    
}

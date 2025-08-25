//
//  LoginView.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 03/02/25.
//


import UIKit

class LoginView: UIView{
    
    var registerClouser: (() -> Void)?
    
    var loginClouser: (() -> Void)?
    
    var forgetPasswordClouser: (() -> Void)?
    
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
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kirish"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = #colorLiteral(red: 0.4147184491, green: 0.4642122388, blue: 0.4990584254, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let emailTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Telefon raqamingizni kiriting")
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.textFieldView.placeholder  = "Enter your email"
        return textField
    }()
    
    let passwordTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Parolni kiriting")
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.textFieldView.placeholder = "Enter your password"
//        textField.textFieldView = .roundedRect
        return textField
    }()
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Parolni unutdingizmi?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = #colorLiteral(red: 0.4147184491, green: 0.4642122388, blue: 0.4990584254, alpha: 1)
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Kirish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.addTarget(LoginView.self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let fullText = "Hisob mavjud emasmi? Hisob yaratish"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // "Don't have an account?" ni kul rangga o'zgartirish
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: 20))
        
        // "Register" ni ko'k rangga o'zgartirish
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 20, length: 15))
        
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(LoginView.self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
        let hideKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(dismissKeyboard))
        hideKeyboardTap.cancelsTouchesInView = false
        self.addGestureRecognizer(hideKeyboardTap)
        
        let forgetPasswordTap = UITapGestureRecognizer(target: self, action: #selector(forgetPasswordTapped))
        forgotPasswordLabel.addGestureRecognizer(forgetPasswordTap)
        
    }
    
    
    
    private func setupSubviews(){
        self.backgroundColor = .clear
        
        
        self.addSubview(focusAILabel)
        self.addSubview(appLogo)
        self.addSubview(loginLabel)
        self.addSubview(passwordTextField)
        self.addSubview(emailTextField)
        self.addSubview(forgotPasswordLabel)
        self.addSubview(loginButton)
        self.addSubview(registerButton)
        

    
        
        NSLayoutConstraint.activate([
            
            focusAILabel.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(61)),
            focusAILabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(83)),
            focusAILabel.widthAnchor.constraint(equalToConstant: universalWidth(172)),
            focusAILabel.heightAnchor.constraint(equalToConstant: universalHeight(48)),
            
            appLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(61)),
            appLogo.leftAnchor.constraint(equalTo: focusAILabel.rightAnchor, constant: universalWidth(10)),
            appLogo.widthAnchor.constraint(equalToConstant: universalWidth(45)),
            appLogo.heightAnchor.constraint(equalToConstant: universalHeight(45)),
            
            loginLabel.topAnchor.constraint(equalTo: focusAILabel.bottomAnchor, constant: universalHeight(101)),
            loginLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(20)),
            loginLabel.widthAnchor.constraint(equalToConstant: universalWidth(150)),
            loginLabel.heightAnchor.constraint(equalToConstant: universalHeight(36)),
            
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: universalHeight(17)),
            emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(15)),
            emailTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            emailTextField.heightAnchor.constraint(equalToConstant: universalWidth(70)),
            
            passwordTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: universalHeight(90)),
            passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(15)),
            passwordTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            passwordTextField.heightAnchor.constraint(equalToConstant: universalWidth(70)),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: universalHeight(15)),
            forgotPasswordLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -universalWidth(20)),
            forgotPasswordLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(160)),
            forgotPasswordLabel.heightAnchor.constraint(equalToConstant: universalWidth(19)),

            loginButton.heightAnchor.constraint(equalToConstant: universalHeight(54)),
            loginButton.widthAnchor.constraint(equalToConstant: universalWidth(289)),
            loginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(52)),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: universalHeight(-105)),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: universalHeight(15)),
            registerButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            registerButton.widthAnchor.constraint(equalToConstant: windowWidth),
            registerButton.heightAnchor.constraint(equalToConstant: universalHeight(19))
            
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
    
    @objc func forgetPasswordTapped(){
        forgetPasswordClouser?()
    }
    

    @objc func dismissKeyboard() {
            self.endEditing(true)
    }
    
}

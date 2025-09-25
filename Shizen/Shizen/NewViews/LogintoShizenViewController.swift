//
//  LogintoShizenViewController.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 25/09/25.
//

//import UIKit
//
//class LogintoShizenViewController: UIViewController {
//    
//    private let titleLabel = UILabel()
//    private let emailTextField = UITextField()
//    private let otpStack = UIStackView()
//    private let sendButton = UIButton(type: .system)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
//        setupConstraints()
//    }
//    
//    private func setupUI() {
//        // Title
//        titleLabel.text = "Login to Shizen"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        titleLabel.textAlignment = .center
//        
//        // Email
//        emailTextField.placeholder = "Enter your email"
//        emailTextField.borderStyle = .roundedRect
//        emailTextField.keyboardType = .emailAddress
//        emailTextField.autocapitalizationType = .none
//        
//        // OTP cells
//        otpStack.axis = .horizontal
//        otpStack.alignment = .center
//        otpStack.distribution = .fillEqually
//        otpStack.spacing = 8
//        
//        for _ in 0..<6 {
//            let tf = UITextField()
//            tf.borderStyle = .roundedRect
//            tf.textAlignment = .center
//            tf.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//            tf.keyboardType = .numberPad
//            tf.widthAnchor.constraint(equalToConstant: 45).isActive = true
//            otpStack.addArrangedSubview(tf)
//        }
//        
//        // Button
//        sendButton.setTitle("Send OTP", for: .normal)
//        sendButton.backgroundColor = UIColor.systemGreen
//        sendButton.setTitleColor(.white, for: .normal)
//        sendButton.layer.cornerRadius = 12
//        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        
//        // Add views
//        [titleLabel, emailTextField, otpStack, sendButton].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview($0)
//        }
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            // Title
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            // Email
//            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
//            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//            emailTextField.heightAnchor.constraint(equalToConstant: 50),
//            
//            // OTP
//            otpStack.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
//            otpStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            otpStack.heightAnchor.constraint(equalToConstant: 50),
//            
//            // Button
//            sendButton.topAnchor.constraint(equalTo: otpStack.bottomAnchor, constant: 40),
//            sendButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
//            sendButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)
//        ])
//    }
//}

import UIKit

class LogintoShizenViewController: UIViewController {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login to Shizen"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let otpLabel: UILabel = {
        let label = UILabel()
        label.text = "OTP Cells Alternative"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let otpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sendOTPButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send OTP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private var otpCells: [UITextField] = []
    private var otpCode: String = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupOTPCells()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(emailContainerView)
        view.addSubview(otpLabel)
        view.addSubview(otpStackView)
        view.addSubview(sendOTPButton)
        
        // Add email container subviews
        emailContainerView.addSubview(emailIconImageView)
        emailContainerView.addSubview(emailTextField)
    }
    
    private func setupOTPCells() {
        for i in 0..<6 {
            let cell = createOTPCell()
            cell.tag = i
            otpCells.append(cell)
            otpStackView.addArrangedSubview(cell)
        }
    }
    
    private func createOTPCell() -> UITextField {
        let cell = UITextField()
        cell.textAlignment = .center
        cell.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        cell.backgroundColor = UIColor.systemGray6
        cell.layer.cornerRadius = 8
        cell.keyboardType = .numberPad
        cell.addTarget(self, action: #selector(otpCellChanged(_:)), for: .editingChanged)
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cell.widthAnchor.constraint(equalToConstant: 40),
            cell.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return cell
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            // Email Container
            emailContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            emailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailContainerView.heightAnchor.constraint(equalToConstant: 52),
            
            // Email Icon
            emailIconImageView.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor, constant: 16),
            emailIconImageView.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor),
            emailIconImageView.widthAnchor.constraint(equalToConstant: 20),
            emailIconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            // Email TextField
            emailTextField.leadingAnchor.constraint(equalTo: emailIconImageView.trailingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor, constant: -16),
            emailTextField.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor),
            
            // OTP Label
            otpLabel.topAnchor.constraint(equalTo: emailContainerView.bottomAnchor, constant: 32),
            otpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            // OTP Stack View
            otpStackView.topAnchor.constraint(equalTo: otpLabel.bottomAnchor, constant: 16),
            otpStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            otpStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            
            // Send OTP Button
            sendOTPButton.bottomAnchor.constraint(equalTo: otpStackView.bottomAnchor, constant: 70),
            sendOTPButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            sendOTPButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            sendOTPButton.heightAnchor.constraint(equalToConstant: 50),
    
        ])
    }
    
    private func setupActions() {
        sendOTPButton.addTarget(self, action: #selector(sendOTPButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func sendOTPButtonTapped() {
        print("Send OTP button tapped")
        print("Email: \(emailTextField.text ?? "")")
        print("OTP: \(otpCode)")
        
        // Add your OTP sending logic here
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func otpCellChanged(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            // Handle deletion
            updateOTPCode()
            return
        }
        
        // Only allow single digit
        if text.count > 1 {
            textField.text = String(text.last!)
        }
        
        updateOTPCode()
        
        // Move to next cell
        if textField.tag < 5 && !text.isEmpty {
            otpCells[textField.tag + 1].becomeFirstResponder()
        }
        
        // If last cell is filled, dismiss keyboard
        if textField.tag == 5 && !text.isEmpty {
            textField.resignFirstResponder()
        }
    }
    
    private func updateOTPCode() {
        otpCode = otpCells.compactMap { $0.text }.joined()
    }
}

// MARK: - UITextField Delegate (Optional)
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // For OTP cells, only allow single digits
//        if otpCells.contains(textField) {
////            let currentText = textField.text ?? ""
//            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
//            return newText.count <= 1 && (newText.isEmpty || newText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil)
//        }
        return true
    }
}

// MARK: - SceneDelegate Integration
// Add this to your SceneDelegate.swift file:

/*
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let loginVC = LoginViewController()
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }
}
*/

//
//  RegistrationViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 30/01/25.
//


import UIKit

class RegistrationViewController: UIViewControllerExtensions {
    
    //MARK: - Makes safe area dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - UI Elements
    private lazy var registerView: RegistrationView = {
        let view = RegistrationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        //Login button tapped
//        view.loginClouser = {
//            guard let email = self.registerView.emailTextField.textFieldView.text, self.isValidEmail( email),
//                  let password = self.registerView.passwordTextField.textFieldView.text, password.count >= 6 else {
//                self.showAlert(title: "Error", message: "Please enter a valid email and password (min 6 characters).")
//                return
//            }
//            
//            // Perform login logic here (API call, Firebase authentication, etc.)
//            self.showAlert(title: "Success", message: "Login successful!")
//        }
        
        // Register button tapped
        
        view.loginClouser = { [weak self] in
            self?.openViewController(viewController: LoginViewController())
        }
        
        view.registerClouser = {
            self.dismiss(animated: true)
        }
        
        return view
    }()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainBackgroundColor")
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(registerView)
        
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.topAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            registerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            registerView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func registerTapped() {
//        guard let name = nameTextField.text, !name.isEmpty,
//              let email = emailTextField.text, isValidEmail(email),
//              let password = passwordTextField.text, password.count >= 6 else {
//            showAlert(title: "Error", message: "Please enter valid information")
//            return
//        }
//        
//        // Perform registration logic here (API call, database storage, etc.)
//        showAlert(title: "Success", message: "Registration successful!")
    }
    
    // MARK: - Helper Methods
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

//
//  LoginViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 30/01/25.
//

import UIKit

class LoginViewController: UIViewControllerExtensions {
    
    private lazy var loginView: LoginView = {
       let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        //Forget Password Tapped
        view.forgetPasswordClouser = { [weak self] in
            self?.openViewController(viewController: ForgotPasswordViewController())
        }
        
        //Login button tapped
        view.loginClouser = {
            guard let email = self.loginView.emailTextField.textFieldView.text, self.isValidEmail( email),
                  let password = self.loginView.passwordTextField.textFieldView.text, password.count >= 6 else {
                self.showAlert(title: "Error", message: "Please enter a valid email and password (min 6 characters).")
                return
            }
            
            // Perform login logic here (API call, Firebase authentication, etc.)
            self.showAlert(title: "Success", message: "Login successful!")
        }
        
        // Register button tapped
        
        view.registerClouser = { [weak self] in
            self?.openViewController(viewController: RegistrationViewController())
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
        
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func loginTapped() {
        
    }
    
    @objc private func openRegistration() {
        
    }
    
    
    
    // MARK: - Helper Methods
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    //MARK: - Makes safe area dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

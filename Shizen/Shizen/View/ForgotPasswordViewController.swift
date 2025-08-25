//
//  ForgotPasswordViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 03/02/25.
//

import UIKit

class ForgotPasswordViewController: UIViewControllerExtensions {
    
    private lazy var forgetPasswordView: ForgotPasswordView = {
       let view = ForgotPasswordView()
        view.translatesAutoresizingMaskIntoConstraints = false
                
        view.sendButtonClouser = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        view.rememberPasswordClouser = { [weak self] in
            self?.openViewController(viewController: LoginViewController())
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
        
        view.addSubview(forgetPasswordView)
        
        NSLayoutConstraint.activate([
            forgetPasswordView.topAnchor.constraint(equalTo: view.topAnchor),
            forgetPasswordView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            forgetPasswordView.leftAnchor.constraint(equalTo: view.leftAnchor),
            forgetPasswordView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
   
    //MARK: - Makes safe area dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

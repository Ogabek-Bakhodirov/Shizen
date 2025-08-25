//
//  Untitled.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 08/03/25.
//

import UIKit

class UIViewControllerExtensions: UIViewController {
    
    override func viewDidLoad() {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
        
    func openViewController(viewController: UIViewController) {
        let viewController = viewController
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    func enableBackButton(isDark: Bool = false, ViewController: UIViewController){
        lazy var backButton: UIButton = {
           let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage( isDark ? UIImage().getImage(.backArrowWhiteIcon) : UIImage().getImage(.backArrowIcon), for: .normal)
            button.addTarget(self, action: #selector(dismissviewController), for: .touchUpInside)
            return button
        }()
        
        lazy var backLabel: UILabel = {
            let label = UILabel()
            label.text = "Orqaga"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = isDark ? .colorWhite : .colorBlack
            label.font = .systemFont(ofSize: 18, weight: .regular)
            label.textAlignment = .left
            label.isUserInteractionEnabled = true
            return label
        }()
        
        let backLabelTap = UITapGestureRecognizer(target: self, action: #selector(backLabaltapped(_:)))
        backLabel.addGestureRecognizer(backLabelTap)
        
        ViewController.view.addSubview(backLabel)
        ViewController.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(68)),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(10)),
            backButton.widthAnchor.constraint(equalToConstant: universalWidth(20)),
            backButton.heightAnchor.constraint(equalToConstant: universalHeight(20)),
            
            backLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(68)),
            backLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor),
            backLabel.widthAnchor.constraint(equalToConstant: universalWidth(81)),
            backLabel.heightAnchor.constraint(equalToConstant: universalHeight(22))
        ])
    }
    
    @objc func dismissviewController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backLabaltapped(_ gestureRecognizer: UITapGestureRecognizer? = nil) {
        dismissviewController()
    }
    
    
    func reloadView(viewController: UIViewController){
        for i in viewController.view.subviews {
            i.removeFromSuperview()
        }
    }
    
    func showPopup(on viewController: UIViewController, title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.dismiss(animated: true)
        }
    }
}

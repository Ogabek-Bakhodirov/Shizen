//
//  NotReadyScreenViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 13/03/25.
//

import UIKit

class NotReadyScreenViewController: UIViewControllerExtensions {
    
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 100, weight: .regular)
        label.textAlignment = .center
        label.text = "⚙"
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .colorBlack
        label.numberOfLines = 0
        label.text = "Ushbu xizmat tez orada ishga tushadi, noqulaylik uchun uzur."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupSubviews()
    }
    
    func setupSubviews(){
        
        view.addSubview(emojiLabel)
        view.addSubview(titleLabel)
        enableBackButton(ViewController: self)
        
        NSLayoutConstraint.activate([
            emojiLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(350)),
            emojiLabel.widthAnchor.constraint(equalToConstant: universalHeight(100)),
            emojiLabel.heightAnchor.constraint(equalToConstant: universalHeight(100)),
            emojiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: universalHeight(20)),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(55)),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -universalWidth(55)),
            titleLabel.heightAnchor.constraint(equalToConstant: universalHeight(45))
        ])
    }
}

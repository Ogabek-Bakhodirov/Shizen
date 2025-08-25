//
//  HelpViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 11/03/25.
//

import UIKit

class HelpViewController: UIViewControllerExtensions {
    
    private lazy var helpIngoLabel: UILabel = {
        let label = UILabel()
        label.text = "Mutaxassis bilan bog’laning."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "+998 99 966 29 60."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
    
        setupSubviews()
    }
    
    func setupSubviews() {
        
        view.addSubview(helpIngoLabel)
        view.addSubview(numberLabel)
        enableBackButton(ViewController: self)
        
        NSLayoutConstraint.activate([
            helpIngoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(160)),
            helpIngoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(30)),
            helpIngoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -universalWidth(30)),
            helpIngoLabel.heightAnchor.constraint(equalToConstant: universalHeight(19)),
            
            numberLabel.topAnchor.constraint(equalTo: helpIngoLabel.bottomAnchor, constant: universalHeight(15)),
            numberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(30)),
            numberLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -universalWidth(30)),
            numberLabel.heightAnchor.constraint(equalToConstant: universalHeight(19)),

        ])
    }
}

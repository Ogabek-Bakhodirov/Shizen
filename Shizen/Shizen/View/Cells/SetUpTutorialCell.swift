//
//  AppAndWebSitesCell.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 29/11/24.
//

import UIKit

class SetUpTutorialCell: UITableViewCell{
    static let cellName = String(describing: SetUpTutorialCell.self)
    
    lazy var videoTutorialView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorWhite
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Dasturni qanday ishlatiladi?"
         label.textAlignment = .left
         label.textColor = .colorBlack
         label.font = .systemFont(ofSize: 20, weight: .semibold)
         return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        
        self.addSubview(videoTutorialView)
        self.addSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: universalHeight(25)),
            summaryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(33)),
            summaryLabel.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(66)),
            summaryLabel.heightAnchor.constraint(equalToConstant: universalHeight(24)),
            
            videoTutorialView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: universalHeight(25)),
            videoTutorialView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(25)),
            videoTutorialView.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(50)),
            videoTutorialView.heightAnchor.constraint(equalToConstant: universalHeight(295)),
                    
        ])
    }
}















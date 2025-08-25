//
//  MyAwardsCollectionViewCell.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 08/03/25.
//

import UIKit

class MyAwardsCollectionViewCell: UICollectionViewCell {
    
    var rowTappedClouser: (() -> Void)?
    
    lazy var mainBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorWhite
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var awardIconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 50, weight: .regular)
        label.textAlignment = .center
        label.text = "🏆"
        return label
    }()
    
    lazy var awardTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .colorBlack
        label.numberOfLines = 0
        label.text = "Deep Focus Master"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        let appManageRowTap = UITapGestureRecognizer(target: self, action: #selector(rowTappedClouser(_:)))
        mainBackground.addGestureRecognizer(appManageRowTap)
    }
    
    func setupViews(){
        contentView.addSubview(mainBackground)
        mainBackground.addSubview(awardIconLabel)
        mainBackground.addSubview(awardTitleLabel)
        
        NSLayoutConstraint.activate([
            mainBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            awardIconLabel.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: universalHeight(39)),
            awardIconLabel.centerXAnchor.constraint(equalTo: mainBackground.centerXAnchor),
            awardIconLabel.widthAnchor.constraint(equalToConstant: universalWidth(50)),
            awardIconLabel.heightAnchor.constraint(equalToConstant: universalWidth(50)),
            
            awardTitleLabel.topAnchor.constraint(equalTo: awardIconLabel.bottomAnchor, constant: universalHeight(20)),
            awardTitleLabel.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: universalWidth(10)),
            awardTitleLabel.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: -universalWidth(10)),
            awardTitleLabel.heightAnchor.constraint(equalToConstant: universalWidth(40))
        ])
    }
    
    @objc func rowTappedClouser(_ gestureRecognizer: UITapGestureRecognizer? = nil) {
        rowTappedClouser?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

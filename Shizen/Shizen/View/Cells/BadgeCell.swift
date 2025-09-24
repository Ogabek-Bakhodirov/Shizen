//
//  BadgeCell.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 24/09/25.
//

import UIKit

class BadgeCell: UICollectionViewCell {
    
    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(iconBackgroundView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add corner radius to the entire badge cell
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        // Style
        iconBackgroundView.layer.cornerRadius = 30
        iconBackgroundView.clipsToBounds = true
        iconBackgroundView.backgroundColor = UIColor.systemGray6
        
        iconImageView.contentMode = .scaleAspectFit
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            iconBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 60),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 60),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(icon: String, color: UIColor, title: String) {
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = color
        iconBackgroundView.backgroundColor = color.withAlphaComponent(0.15)
        titleLabel.text = title
    }
}

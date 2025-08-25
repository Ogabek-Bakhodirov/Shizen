//
//  ProfileViewCell.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 03/02/25.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    static let cellName = String(describing: ProfileViewCell.self)
    
    private var cellIconImage: UIImage?
    
    private var cellNameString: String?
    
    private lazy var mainBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorWhite
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cellIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = cellIconImage
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var cellSectionName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = cellNameString
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()


    init(cellIconImage: UIImage, cellNameString: String) {
        super.init(style: .default, reuseIdentifier: "ProfileViewCell")
        selectionStyle = .none
        
        setupSubviews(cellIconImage: cellIconImage, cellNameString: cellNameString)
    }
    
    
    func setupSubviews(cellIconImage: UIImage, cellNameString: String) {
        self.cellNameString = cellNameString
        self.cellIconImage = cellIconImage
        self.addSubview(mainBackground)
        mainBackground.addSubview(cellSectionName)
        mainBackground.addSubview(cellIcon)
        
        NSLayoutConstraint.activate([
            mainBackground.topAnchor.constraint(equalTo: self.topAnchor),
            mainBackground.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -universalWidth(40)),
            mainBackground.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(40)),
            mainBackground.heightAnchor.constraint(equalToConstant: universalHeight(53)),
            
            cellIcon.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: universalHeight(18)),
            cellIcon.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: -universalHeight(25)),
            cellIcon.widthAnchor.constraint(equalToConstant: universalWidth(20)),
            cellIcon.heightAnchor.constraint(equalToConstant: universalWidth(20)),
            
            cellSectionName.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: universalHeight(15)),
            cellSectionName.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: universalHeight(15)),
            cellSectionName.widthAnchor.constraint(equalToConstant: universalWidth(250)),
            cellSectionName.heightAnchor.constraint(equalToConstant: universalWidth(23)),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

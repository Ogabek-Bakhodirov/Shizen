//
//  LeaderBoardTableViewCell.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 08/03/25.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {
    static let cellName = String(describing: LeaderBoardTableViewCell.self)
    
    private var userPoint: String?
    
    private var cellNameString: String?
    
    private var cellNumber: String?
        
    private lazy var mainBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorWhite
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cellSectionName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = cellNameString
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var userPointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = userPoint
        label.textColor = .lightTextColor
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var rowNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = cellNumber
        label.textColor = .lightTextColor
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()


    init(userPoint: String, cellNameString: String, cellNumber: String) {
        super.init(style: .default, reuseIdentifier: "ProfileViewCell")
        selectionStyle = .none
        
        setupSubviews(userPoint: userPoint, cellNameString: cellNameString, cellNumber: cellNumber)
    }
    
    
    func setupSubviews(userPoint: String, cellNameString: String, cellNumber: String) {
        self.cellNameString = cellNameString
        self.userPoint = userPoint
        self.cellNumber = cellNumber
        contentView.addSubview(mainBackground)
        mainBackground.addSubview(cellSectionName)
        mainBackground.addSubview(rowNumber)
        mainBackground.addSubview(userPointLabel)
        
        NSLayoutConstraint.activate([
            mainBackground.topAnchor.constraint(equalTo: self.topAnchor),
            mainBackground.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -universalWidth(40)),
            mainBackground.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(40)),
            mainBackground.heightAnchor.constraint(equalToConstant: universalHeight(53)),
            
            rowNumber.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: universalHeight(15)),
            rowNumber.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: universalHeight(10)),
            rowNumber.widthAnchor.constraint(equalToConstant: universalHeight(25)),
            rowNumber.heightAnchor.constraint(equalToConstant: universalWidth(23)),
            
            cellSectionName.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: universalHeight(15)),
            cellSectionName.leftAnchor.constraint(equalTo: rowNumber.rightAnchor, constant: universalHeight(10)),
            cellSectionName.widthAnchor.constraint(equalToConstant: universalWidth(230)),
            cellSectionName.heightAnchor.constraint(equalToConstant: universalWidth(23)),
            
            userPointLabel.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: universalHeight(15)),
            userPointLabel.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: -universalHeight(10)),
            userPointLabel.widthAnchor.constraint(equalToConstant: universalHeight(85)),
            userPointLabel.heightAnchor.constraint(equalToConstant: universalWidth(23)),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

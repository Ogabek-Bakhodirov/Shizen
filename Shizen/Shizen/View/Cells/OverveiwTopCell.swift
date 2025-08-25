//
//  OverveiwTopCell.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 29/11/24.
//

import UIKit

class OverveiwTopCell: UITableViewCell {
    
    static let cellName = String(describing: OverveiwTopCell.self)
    
    var startFocusClouser: (() -> Void)?
        
    var awardsRowClouser: (() -> Void)?
    
    var leaderBoardRowClouser: (() -> Void)?
    
    lazy var overViewLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Umumiy"
        label.textAlignment = .left
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var startFocus: UIView = {
        let view = createRow(title: "Diqqat rejimi", logo: .lockEmoji, textColor: .colorWhite)
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var awardsRow: UIView = {
        let view = createRow(title: "Yutuqlar", logo: .cupAwardIcon)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var leaderBoardRow: UIView = {
        let view = createRow(title: "Qahramonlar Jadvali", logo: .leaderBoardIcon)
        view.isUserInteractionEnabled = true
        return view
    }()

    func createRow(title: String, logo: UIImageEnum, textColor: UIColor = .colorBlack) -> UIView {
        let mainBackgroundView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .colorWhite
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            return view
        }()
        
        let rowTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = title
            label.textColor = textColor
            label.font = .systemFont(ofSize: 16, weight: .regular)
            return label
        }()
        
        let rowIcon: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage().getImage(logo), for: .normal)
            return button
        }()
        
        mainBackgroundView.addSubview(rowTitle)
        mainBackgroundView.addSubview(rowIcon)

        NSLayoutConstraint.activate([
            // Setting size constraints for the mainBackgroundView
            mainBackgroundView.heightAnchor.constraint(equalToConstant: universalHeight(53)),
            mainBackgroundView.widthAnchor.constraint(equalToConstant: universalWidth(360)),

            // Title label constraints
            rowTitle.centerYAnchor.constraint(equalTo: mainBackgroundView.centerYAnchor),
            rowTitle.leftAnchor.constraint(equalTo: mainBackgroundView.leftAnchor, constant: universalWidth(20)),

            // Icon button constraints
            rowIcon.centerYAnchor.constraint(equalTo: mainBackgroundView.centerYAnchor),
            rowIcon.rightAnchor.constraint(equalTo: mainBackgroundView.rightAnchor, constant: universalWidth(-17)),
            rowIcon.widthAnchor.constraint(equalToConstant: universalWidth(18)),
            rowIcon.heightAnchor.constraint(equalToConstant: universalHeight(18)),
        ])

        return mainBackgroundView
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
                
        setupSubviews()
        let startFocusRowTap = UITapGestureRecognizer(target: self, action: #selector(startFocusRowTapped(_:)))
        startFocus.addGestureRecognizer(startFocusRowTap)
        
        let awardsRowTap = UITapGestureRecognizer(target: self, action: #selector(awardsRowTapped(_:)))
        awardsRow.addGestureRecognizer(awardsRowTap)
        
        let leaderBoardRowTap = UITapGestureRecognizer(target: self, action: #selector(leaderBoardRowTapped(_:)))
        leaderBoardRow.addGestureRecognizer(leaderBoardRowTap)
    }
    
    
    func setupSubviews(){
        
        contentView.addSubview(overViewLabel)
        contentView.addSubview(startFocus)
        contentView.addSubview(awardsRow)
        contentView.addSubview(leaderBoardRow)
            
            NSLayoutConstraint.activate([

                overViewLabel.topAnchor.constraint(equalTo: self.topAnchor),
                overViewLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(33)),
                overViewLabel.widthAnchor.constraint(equalToConstant: universalWidth(150)),
                overViewLabel.heightAnchor.constraint(equalToConstant: universalHeight(24)),
                
                startFocus.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: universalHeight(10)),
                startFocus.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(40)),
                startFocus.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(80)),
                startFocus.heightAnchor.constraint(equalToConstant: universalHeight(53)),
                
                awardsRow.topAnchor.constraint(equalTo: startFocus.bottomAnchor, constant: universalHeight(10)),
                awardsRow.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(40)),
                awardsRow.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(80)),
                awardsRow.heightAnchor.constraint(equalToConstant: universalHeight(53)),
                
                leaderBoardRow.topAnchor.constraint(equalTo: awardsRow.bottomAnchor, constant: universalHeight(10)),
                leaderBoardRow.leftAnchor.constraint(equalTo: self.leftAnchor, constant: universalWidth(40)),
                leaderBoardRow.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(80)),
                leaderBoardRow.heightAnchor.constraint(equalToConstant: universalHeight(53))
                
                        
            ])
    }

    
    @objc func startFocusRowTapped(_ gestureRecognizer: UITapGestureRecognizer? = nil) {
        startFocusClouser?()
        print("start focus")
    }
    
    @objc func awardsRowTapped(_ gestureRecognizer: UITapGestureRecognizer? = nil) {
        awardsRowClouser?()
        print("awards")
    }

    
    @objc func leaderBoardRowTapped(_ gestureRecognizer: UITapGestureRecognizer? = nil) {
        leaderBoardRowClouser?()
        print("leaderBoard")
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

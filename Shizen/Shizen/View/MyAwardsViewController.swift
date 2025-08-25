//
//  MyAwardsViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 07/03/25.
//


import UIKit
import SwiftUI

class MyAwardsViewController: UIViewControllerExtensions {
      
    private var awardBase: [AwardManagerEnum : Bool ] = AwardBase.shared.getAwardBase()
    
    private let cupBackgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage().getImage(.cupImage)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    //Collection View
    
    let layout = UICollectionViewFlowLayout()
    
    func createLayout() -> UICollectionViewFlowLayout {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = universalHeight(20) // Space between rows
        layout.minimumInteritemSpacing = universalWidth(25)// Space between items in the same row
        return layout
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    func setupCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MyAwardsCollectionViewCell.self, forCellWithReuseIdentifier: "MyAwardsCollectionViewCell")

    }
          
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupSubviews()
    }
    
    func setupSubviews(){
        
        setupCollectionView()
        
        view.addSubview(cupBackgroundImage)
        view.addSubview(collectionView)
        
        enableBackButton(isDark: true ,ViewController: self)
        
        NSLayoutConstraint.activate([
            
            cupBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(22)),
            cupBackgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalHeight(10)),
            cupBackgroundImage.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(20)),
            cupBackgroundImage.heightAnchor.constraint(equalToConstant: universalWidth(334)),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(300)),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(30)), //
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -universalWidth(30)),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
        ])
    }
    
    //MARK: - Makes safe area dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

extension MyAwardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        awardBase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let keys = Array(awardBase.keys)  // Get the keys as an array

        let key = keys[indexPath.row]  // Get the key for the specific index
        let value = awardBase[key]  // Get the value corresponding to the key
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyAwardsCollectionViewCell", for: indexPath) as! MyAwardsCollectionViewCell
        cell.mainBackground.backgroundColor = value ?? false ? .colorWhite : .lightTextColor
        cell.awardIconLabel.text = "🏆"
        cell.awardTitleLabel.text = key.award.awardTitle
        cell.rowTappedClouser = { [weak self] in
            let starrySkyView = UIHostingController(rootView: AwardDescriptionView(award: key))
            starrySkyView.modalPresentationStyle = .fullScreen
            self?.present(starrySkyView, animated: true, completion: nil)
        }
        return cell
    }
}


extension MyAwardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: universalWidth(145), height: universalHeight(185)) // Square cells
    }
}

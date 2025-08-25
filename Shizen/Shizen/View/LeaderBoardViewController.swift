//
//  LeaderBoardViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 08/03/25.
//


import UIKit

class LeaderBoardViewController: UIViewControllerExtensions {
    
    let leaderBoardStruct: [LeaderBoardStruct] = [
        LeaderBoardStruct(userPoint: "333pnt", cellNameString: "Jack Daniels")
    ]
    
    func createLeaderBoardForTop3(size: CGRect, image: UIImage, name: String, point: Float, place: Int) -> UIView {
        let mainView = UIView(frame: size)
        mainView.backgroundColor = .clear
        view.addSubview(mainView)
        
        let profileImage = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.width))
        profileImage.image = image
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = #colorLiteral(red: 0.3294508755, green: 0.3900665045, blue: 0.4275643229, alpha: 1)
        mainView.addSubview(profileImage)
        
        let nameTitle = UILabel(frame: CGRect(x: 0, y: size.width + universalHeight(10), width: size.width, height: 23))
        nameTitle.text = name
        nameTitle.textColor = .colorBlack
        nameTitle.textAlignment = .center
        nameTitle.font = .systemFont(ofSize: 16, weight: .semibold)
        mainView.addSubview(nameTitle)
        
        let score = UILabel(frame: CGRect(x: 0, y: size.width + universalHeight(33), width: size.width, height: 23))
        score.text = "\(point)"
        score.textColor = .lightTextColor
        score.textAlignment = .center
        score.font = .systemFont(ofSize: 16, weight: .regular)
        mainView.addSubview(score)

        let placeView = UIView(frame: CGRect(x: size.width - 30, y: size.width - 30, width: 30, height: 30))
        placeView.backgroundColor = .lightTextColor
        placeView.layer.cornerRadius = placeView.frame.width / 2
        mainView.addSubview(placeView)
        
        let placeNumber = UILabel(frame: CGRect(x: 5, y: 4, width: placeView.frame.width - 10, height: placeView.frame.width - 8))
        placeNumber.text = "\(place)"
        placeNumber.textColor = .colorWhite
        placeNumber.textAlignment = .center
        placeNumber.font = .systemFont(ofSize: 16, weight: .bold)
        placeView.addSubview(placeNumber)
        
        return mainView
    }
    func setupTopPlaces(){
        let firstPlace: UIView =  createLeaderBoardForTop3(size: CGRect(x: windowWidth - (windowWidth / 2 + universalWidth(57)),
                                                                    y: universalHeight(65),
                                                                    width: universalWidth(114), height: universalHeight(160)),
                                                           image: #imageLiteral(resourceName: "SnoopDogImage"), name: "Jack Daniels", point: 333.0, place: 1)
        
        let secondPlace: UIView =  createLeaderBoardForTop3(size: CGRect(x: universalWidth(20),
                                                                    y: universalHeight(200),
                                                                    width: universalWidth(114), height: universalHeight(160)),
                                                           image: #imageLiteral(resourceName: "SnoopDogImage"), name: "Snoop Dog", point: 323.0, place: 2)
        
        let thirdPlace: UIView =  createLeaderBoardForTop3(size: CGRect(x: windowWidth - universalWidth(134),
                                                                    y: universalHeight(200),
                                                                    width: universalWidth(114), height: universalHeight(160)),
                                                           image: #imageLiteral(resourceName: "SnoopDogImage"), name: "Snoop Dog Fake", point: 310.0, place: 3)
        self.view.addSubview(firstPlace)
        self.view.addSubview(secondPlace)
    }
    
    
    
    private lazy var leaderBoardTitle: UILabel = {
        let label = UILabel()
        label.text = "Qahramonlar jadvali"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorBlack
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var mainTabledView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(LeaderBoardTableViewCell.self, forCellReuseIdentifier: LeaderBoardTableViewCell.cellName)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        
        return view
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupSubviews()
    }
    
    private func setupSubviews(){
        
        view.addSubview(mainTabledView)
        view.addSubview(leaderBoardTitle)
        setupTopPlaces()
        enableBackButton(ViewController: self)
        
        NSLayoutConstraint.activate([
            
            mainTabledView.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(410)),
            mainTabledView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTabledView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTabledView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            leaderBoardTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(380)),
            leaderBoardTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalHeight(25)),
            leaderBoardTitle.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
            leaderBoardTitle.heightAnchor.constraint(equalToConstant: universalWidth(24)),
            
        ])
    }
    
    @objc func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backLabalTapped(_ gestureRecognizer: UITapGestureRecognizer? = nil) {
        dismissViewController()
    }
    
    //MARK: - Makes safe area dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

extension LeaderBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeaderBoardTableViewCell(userPoint: leaderBoardStruct[0].userPoint, cellNameString: leaderBoardStruct[0].cellNameString, cellNumber: "\(indexPath.row+1)")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        universalHeight(63)
    }
}

struct LeaderBoardStruct{
    let userPoint: String
    let cellNameString: String
}

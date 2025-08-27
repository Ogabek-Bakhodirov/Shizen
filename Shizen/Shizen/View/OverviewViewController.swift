//
//  OverviewViewController.swift
//  Focus
//
//  Created by Ogabek Bakhodirov on 27/11/24.
//

import UIKit
import FamilyControls
import SwiftUI
import UserNotifications
import Network

class OverviewViewController: UIViewControllerExtensions {
            
    lazy var notificationBellLogo: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage().getImage(.notificationBellBlackLogo), for: .normal)
        button.addTarget(self, action: #selector(onClickNotification), for: .touchUpInside)
        return button
    }()
    
    lazy var settingsLogo: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage().getImage(.settingBlackLogo), for: .normal)
        button.addTarget(self, action: #selector(onClickSettings), for: .touchUpInside)
        return button
    }()
    
    private let monthView: ActivityCalendarView = {
        let view = ActivityCalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        let history = UserModel.shared.focusSession[0].tractionHistory
        // Configure data
        view.month = Date() // current month
        view.applyTractionHistory(history)
//        view.squareSize = 18
//        view.spacing = 6
//        view.activeDays = [1,2,3,5,6,8,9,10,14,15,18,21,22,25,28,30]
        return view
    }()
    
    lazy var mainTabledView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(OverveiwTopCell.self, forCellReuseIdentifier: OverveiwTopCell.cellName)
        view.register(SetUpTutorialCell.self, forCellReuseIdentifier: SetUpTutorialCell.cellName)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        
        return view
    }()
    
    
    func askForPermissionNotifications() {
        let notificationCenter = UNUserNotificationCenter.current ()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
                case .authorized:
                    print("\nauthorized\n")
                case .denied:
                    return
                case .notDetermined:
                    notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                        if didAllow {
                            print("\nnotDetermined\n")
                        }
                    }
                default:
                    return
            }
        }
    }


    func setupSubviews(){
        view.addSubview(monthView)
        view.addSubview(settingsLogo)
        view.addSubview(notificationBellLogo)
        view.addSubview(mainTabledView)
        
        NSLayoutConstraint.activate([
            
            monthView.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(112)),
            monthView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalHeight(20)),
            monthView.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
            monthView.heightAnchor.constraint(equalToConstant: universalWidth(300)),
            
            notificationBellLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(68)),
            notificationBellLogo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: universalWidth(-20)),
            notificationBellLogo.widthAnchor.constraint(equalToConstant: universalWidth(24)),
            notificationBellLogo.heightAnchor.constraint(equalToConstant: universalHeight(24)),
            
            settingsLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(68)),
            settingsLogo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(20)),
            settingsLogo.widthAnchor.constraint(equalToConstant: universalWidth(24)),
            settingsLogo.heightAnchor.constraint(equalToConstant: universalHeight(24)),
            
            mainTabledView.topAnchor.constraint(equalTo: monthView.bottomAnchor, constant: universalHeight(1)),
            mainTabledView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTabledView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTabledView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        askForPermissionNotifications()
    }
    
    @objc func onClickSettings(){
        openViewController(viewController: ProfileViewController())
    }
    
    @objc func onClickNotification(){
        openViewController(viewController: NotReadyScreenViewController())
    }
}

extension OverviewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverveiwTopCell.cellName) as? OverveiwTopCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            
            cell.startFocusClouser = { [weak self] in
                if let self = self{
                    if self.isInternetAvailable() {
                        self.showPopup(on: self, title: "Telefoningiz Internetga ulangan.", message: "Focus rejimi ishlashi uchun iltimos qurulmani WiFi va interdan uzing.")
                    } else {
                        self.openViewController(viewController: PomodoroViewController())
                    }
                }
            }
            
            cell.awardsRowClouser = { [weak self] in
                self?.openViewController(viewController: MyAwardsViewController())
            }
            
            cell.leaderBoardRowClouser = { [weak self] in
                self?.openViewController(viewController: LeaderBoardViewController())
                
            }
            
            return cell 
        } else if indexPath.row  == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SetUpTutorialCell.cellName) as? SetUpTutorialCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell 
        } else {
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {return universalHeight(225) }
        else if indexPath.row == 1 { return universalHeight(400) }
        else { return 0 }
    }
    
    //MARK: - Makes safe area dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}


extension OverviewViewController {
    func isInternetAvailable() -> Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        var status: Bool = false
        let semaphore = DispatchSemaphore(value: 0)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // Internet is available
                status = true
            } else {
                // No internet
                status = false
            }
            semaphore.signal()
            monitor.cancel()
        }

        monitor.start(queue: queue)
        semaphore.wait()
        return status
    }
}

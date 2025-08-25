////
////  TabbarViewController.swift
////  Focus AI
////
////  Created by Ogabek Bakhodirov on 03/02/25.
////
//
//import UIKit
//
//class TabBarController: UITabBarController{
//        
//    let overviewController = OverviewViewController()
//    let profileViewController = ProfileViewController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tabBar.tintColor = .white
//        tabBar.barTintColor = #colorLiteral(red: 0.05196797848, green: 0.1966994107, blue: 0.3150942922, alpha: 1)
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        tabBar.isTranslucent = false
//        addTabbarItems()
//    }
//
//    
//
//
//    
//    func addTabbarItems(){
//        overviewController.tabBarItem.image = UIImage(named: "homeIcon")
//        overviewController.tabBarItem.title = "Home"
//
//        profileViewController.tabBarItem.image = UIImage(named: "userIconCircle")
//        profileViewController.tabBarItem.title = "Profile"
//
//        
//        viewControllers = [overviewController, profileViewController]
//        setViewControllers(viewControllers, animated: true)
//    }
//}
//
//
////MARK: - Makes safe area dark
//extension TabBarController {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
//}

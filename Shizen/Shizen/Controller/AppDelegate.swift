//
//  AppDelegate.swift
//  Focus
//
//  Created by Ogabek Bakhodirov on 27/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    //MARK: - did Finish Launching With Options
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        UserModel.shared.checkAndUpdateDailySessions()
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = ChallengesViewController()
        return true
    }
}

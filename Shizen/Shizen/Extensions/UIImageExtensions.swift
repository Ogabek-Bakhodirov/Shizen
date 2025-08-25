//
//  UIImageExtensions.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 06/03/25.
//

import UIKit

extension UIView {
    public func getImage(_ imageEnum: UIImageEnum) -> UIImage {
        return UIImage().getImage(imageEnum)
    }
}

extension UIImage {
    
    public func getImage(_ imageEnum: UIImageEnum) -> UIImage {
//       return SharedManager.isLightMode() ? self.getImageForLight(imageEnum) : self.getImageForDark(imageEnum)
        self.getImageForLight(imageEnum)
    }
    
    private func getImageForLight(_ imageEnum: UIImageEnum) -> UIImage {
        
        switch imageEnum  {
            case .circleAppLogo : return UIImage(named: "CircleAppLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "CircleAppLogo")
            case .appLogo : return UIImage(named: "AIAvatar")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "AIAvatar")
            case .notification : return UIImage(named: "notificationBellLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "notificationBellLogo")
            case .settingLogo : return UIImage(named: "settingLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "settingLogo")
            case .soonHeroImage : return UIImage(named: "soonHeroImage")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "soonHeroImage")
            case .leaderBoardIcon : return UIImage(named: "leaderBoardIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "leaderBoardIcon")
            case .cupAwardIcon : return UIImage(named: "cupAwardIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "cupAwardIcon")
            case .lockIcon : return UIImage(named: "lockIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "lockIcon")
            case .backArrowIcon : return UIImage(named: "backArrowIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "backArrowIcon")
            case .cupImage : return UIImage(named: "cupImage")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "cupImage")
            case .backArrowWhiteIcon : return UIImage(named: "backArrowWhiteIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "backArrowWhiteIcon")
            case .notificationBellBlackLogo : return UIImage(named: "notificationBellBlackLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "notificationBellBlackLogo")
            case .settingBlackLogo : return UIImage(named: "settingBlackLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "settingBlackLogo")
            case .focusedPersonLogo : return UIImage(named: "focusedPersonLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "focusedPersonLogo")
            case .lockEmoji : return UIImage(named: "lockEmoji")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "lockEmoji")


        }
    }

    //MARK: - Dark images
    private func getImageForDark(_ imageEnum: UIImageEnum) -> UIImage {
        switch imageEnum  {
            case .circleAppLogo : return UIImage(named: "CircleAppLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "CircleAppLogo")
            case .appLogo : return UIImage(named: "AIAvatar")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "AIAvatar")
            case .notification : return UIImage(named: "notificationBellLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "notificationBellLogo")
            case .settingLogo : return UIImage(named: "settingLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "settingLogo")
            case .soonHeroImage : return UIImage(named: "soonHeroImage")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "soonHeroImage")
            case .leaderBoardIcon : return UIImage(named: "leaderBoardIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "leaderBoardIcon")
            case .cupAwardIcon : return UIImage(named: "cupAwardIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "cupAwardIcon")
            case .lockIcon : return UIImage(named: "lockIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "lockIcon")
            case .backArrowIcon : return UIImage(named: "backArrowIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "backArrowIcon")
            case .cupImage : return UIImage(named: "cupImage")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "cupImage")
            case .backArrowWhiteIcon : return UIImage(named: "backArrowWhiteIcon")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "backArrowWhiteIcon")
            case .notificationBellBlackLogo : return UIImage(named: "notificationBellBlackLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "notificationBellBlackLogo")
            case .settingBlackLogo : return UIImage(named: "settingBlackLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "settingBlackLogo")
            case .focusedPersonLogo : return UIImage(named: "focusedPersonLogo")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "focusedPersonLogo")
            case .lockEmoji : return UIImage(named: "lockEmoji")?.withRenderingMode(.alwaysOriginal) ?? #imageLiteral(resourceName: "lockEmoji")
        }
    }
}




public enum UIImageEnum {
    
    case notification
    case circleAppLogo
    case appLogo
    case settingLogo
    case soonHeroImage
    case leaderBoardIcon
    case cupAwardIcon
    case lockIcon
    case backArrowIcon
    case cupImage
    case backArrowWhiteIcon
    case notificationBellBlackLogo
    case settingBlackLogo
    case focusedPersonLogo
    case lockEmoji
}


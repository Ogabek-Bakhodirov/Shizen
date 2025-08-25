//
//  GlobalFunctions.swift
//  Focus
//
//  Created by Ogabek Bakhodirov on 29/11/24.
//

import UIKit
import FamilyControls
import DeviceActivity
import UserNotifications

public func universalHeight(_ height: CGFloat) -> CGFloat {
    return height / 812 * windowHeight
}

public func universalWidth(_ width: CGFloat) -> CGFloat {
    return width / 375 * windowWidth
}

// Function to calculate UILabel size
public func calculateLabelSize(for text: String, font: UIFont, maxWidth: CGFloat) -> CGSize {
    // Create a temporary UILabel
    let label = UILabel()
    label.text = text
    label.font = font
    label.numberOfLines = 0 // Enable multi-line
    label.lineBreakMode = .byWordWrapping
    
    // Calculate size
    let maxSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
    let requiredSize = label.sizeThatFits(maxSize)
    
    return requiredSize
}

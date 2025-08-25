//
//  UILabelExtensions.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 29/01/25.
//

import UIKit

extension UILabel {
    func getSelfSize(maxWidth width: CGFloat) -> CGSize {
        return calculateLabelSize(for: self.text ?? "", font: self.font, maxWidth: width)
    }
}

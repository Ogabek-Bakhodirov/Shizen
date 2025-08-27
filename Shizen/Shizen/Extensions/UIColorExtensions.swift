//
//  UIColorExtensions.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 06/03/25.
//

import UIKit

extension UIColor {
    
    public static var mainBackgroundColor = getColor(from: "#EFEEF4")
    public static var colorWhite = makeCustomColor(255, 255, 255)
    public static var colorBlack = makeCustomColor(0, 0, 0)
    public static var colorMainTransparent = makeCustomColor(0, 178, 169,0.25)
    public static var colorBlue = makeCustomColor(52, 119, 248)
    public static var lightTextColor = getColor(from: "#808080")
    public static var secondLightTextColor = getColor(from: "#57636C")
    public static var ultraActiveColor = getColor(from: "#063b00")
    public static var maxActiveColor = getColor(from: "#0a5d00")
    public static var proActiveColor = getColor(from: "#089000")
    public static var activeColor = getColor(from: "#1fc600")
    

    
    public static func makeCustomColor(_ r: CGFloat,_ g: CGFloat,_ b:CGFloat,_ a: CGFloat = 1.0) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    public static func initForLightMode() {
        colorBlack = makeCustomColor(0, 0, 0)
        colorWhite = makeCustomColor(255, 255, 255)
        mainBackgroundColor = getColor(from: "#EFEEF4")
        lightTextColor = getColor(from: "#808080")
        colorBlue = makeCustomColor(52, 119, 248)
        secondLightTextColor = getColor(from: "#57636C")
    }
    
    public static func initForDarkMode() {
        mainBackgroundColor = makeCustomColor(0, 0, 0)
        colorBlack = makeCustomColor(255, 255, 255)
        colorWhite = getColor(from: "#000000")
        lightTextColor = getColor(from: "#808080")
        colorBlue = makeCustomColor(52, 119, 248)
        secondLightTextColor = getColor(from: "#57636C")
    }
    
    public static func getColor(from hex: String,_ withAlpha: Bool = true) -> UIColor {
        let r, g, b : CGFloat
        var a : CGFloat = 1.0
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = (CGFloat(hexNumber & 0x000000ff) / 255)
                    a = (a < 1) ? a : 0.55
                    return UIColor(red: r, green: g, blue: b, alpha: withAlpha ? a : 1)
                }
            } else
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    a = 1.0
                    
                    return UIColor(red: r, green: g, blue: b, alpha: withAlpha ? a : 1)
                }
            }
        }
        return .colorMainTransparent
    }
    
    public static func get(from hex: String,_ withAlpha: Bool = true) -> UIColor? {
        let r, g, b : CGFloat
        var a : CGFloat = 1.0
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = (CGFloat(hexNumber & 0x000000ff) / 255)
                    a = (a < 1) ? a : 0.55
                    return UIColor(red: r, green: g, blue: b, alpha: withAlpha ? a : 1)
                }
            } else
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    a = 1.0
                    
                    return UIColor(red: r, green: g, blue: b, alpha: withAlpha ? a : 1)
                }
            }
        }
        return nil
    }
    
    public static func makeGradientColorForSiri(_ b: UIColor,_ e: UIColor, _ style: GradientStyles = .leftToRight) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [b.cgColor, e.cgColor]
        gradientLayer.shouldRasterize = true
        switch style {
        case .leftToRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            break
            
        case .topToBottom :
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            break
            
        case .leftTopToBottomRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            break
            
        case .leftBottomToTopRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            break
        }
        
        return gradientLayer
    }
    
    
    public static func makeGradientColor(_ b: UIColor,_ e: UIColor, _ style: GradientStyles = .leftToRight) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [b.cgColor, e.cgColor]
        gradientLayer.shouldRasterize = true
        switch style {
        case .leftToRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            break
            
        case .topToBottom :
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            break
            
        case .leftTopToBottomRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            break
            
        case .leftBottomToTopRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            break
        }
        
        return gradientLayer
    }
    
    public static func makeGradientColorThree(_ b: UIColor,_ e: UIColor, _ c: UIColor, _ style: GradientStyles = .leftToRight) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [b.cgColor, e.cgColor, c.cgColor]
        gradientLayer.shouldRasterize = true
        switch style {
        case .leftToRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            break
            
        case .topToBottom :
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            break
            
        case .leftTopToBottomRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            break
            
        case .leftBottomToTopRight :
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            break
        }
        
        return gradientLayer
    }
    
    public static var splashBackGroundGradient = makeGradientColor(.getColor(from: "#181D1B"), .getColor(from: "#1E4335") , .topToBottom)
    
    
    public static func getGradient(_ left: String?, _ right: String?, _ withAplha: Bool = true) -> CAGradientLayer {
        return self.makeGradientColor(self.getColor(from: left ?? "11ff00", withAplha), self.getColor(from: right ?? "00ff22", withAplha))
    }
    
//    public static func getStatusStyle() -> UIBarStyle {
//        let mode = SharedManager.getApplicationTheme()
//        switch mode {
//        case .light: return .default
//        case .dark: return .black
//        }
//    }
    
//    public static func getNegStatusStyle() -> UIBarStyle {
//        let mode = SharedManager.getApplicationTheme()
//        switch mode {
//        case .light: return .black
//        case .dark: return .default
//        }
//    }
    
//    @available(iOS 12.0, *)
//    public static func getUIStatusStyle() -> UIUserInterfaceStyle {
//        let mode = SharedManager.getApplicationTheme()
//        switch mode {
//        case .light: return .light
//        case .dark: return .dark
//        }
//    }
    
//    @available(iOS 12.0, *)
//    public static func getNegUIStatusStyle() -> UIUserInterfaceStyle {
//        let mode = SharedManager.getApplicationTheme()
//        switch mode {
//        case .light: return .dark
//        case .dark: return .light
//        }
//    }
}
 

public enum GradientStyles : Int {
    case topToBottom = 100
    case leftToRight
    case leftTopToBottomRight
    case leftBottomToTopRight
}

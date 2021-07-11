//
//  XYColors.swift
//  XYWidgets
//
//  Created by Maxime Franchot on 10/07/21.
//

import UIKit


extension UIColor {
    static var XYWhite: UIColor {
        get {
            UIColor(white: 0.96, alpha: 1.0)
        }
        set {
            self.XYWhite = newValue
        }
    }
    
    static var XYBlack: UIColor {
        get {
            UIColor(white: 0.04, alpha: 1.0)
        }
        set {
            self.XYBlack = newValue
        }
    }
    
    static var XYLight: UIColor {
        get {
            UIColor(white: 0.89, alpha: 1.0)
        }
        set {
            self.XYLight = newValue
        }
    }
    
    static var XYDark: UIColor {
        get {
            UIColor(white: 0.14, alpha: 1.0)
        }
        set {
            self.XYLight = newValue
        }
    }
    
    static var XYBackground: UIColor {
        get {
            return UITraitCollection.current.userInterfaceStyle == .dark
                ? XYBlack : XYWhite
        }
    }
    
    static var XYCard: UIColor {
        get {
            return UITraitCollection.current.userInterfaceStyle == .dark
                ? XYDark : XYLight
        }
    }
    
    static var XYTint: UIColor {
        get {
            return UITraitCollection.current.userInterfaceStyle == .dark
                ? XYWhite : XYBlack
        }
    }
}

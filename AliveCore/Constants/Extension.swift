//
//  Extension.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import Foundation
import UIKit


//MARK:- UIDevice

extension UIDevice {
    var isSimulator: Bool {
        #if arch(i386) || arch(x86_64)
        return true
        #else
        return false
        #endif
    }
}

//MARK:- Float

extension Float {
    
    var convertAsLocaleCurrency :String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: self as NSNumber)!
    }
    
    var convertAsUSDCurrency :String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self as NSNumber)!
    }
}

//MARK:- Double

extension Double {
    
    /// Returns propotional height according to device height
    var propotionalHeight: CGFloat {
        return Screen.height / CGFloat(IPHONE6_HEIGHT) * CGFloat(self)
    }
    
    /// Returns propotional width according to device width
    var propotional: CGFloat {
        if isIpad {
            return CGFloat(IPHONE6_WIDTH) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
        }
        return CGFloat(Screen.width) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
    }
    
    var propotionalFont: CGFloat {
        if isIpad {
            return CGFloat(IPHONE6_WIDTH) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
        }
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            return CGFloat(Screen.width) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
        } else {
            return CGFloat(Screen.height) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
        }
    }
    
    /// Returns rounded value for passed places
    ///
    /// - parameter places: Pass number of digit for rounded value off after decimal
    ///
    /// - returns: Returns rounded value with passed places
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}

//MARK:- UILabel

extension UILabel {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}


//MARK:- UIButton

extension UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}

//MARK:- UIApplication

extension UIApplication {
    
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.currentWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    static var isDeviceWithSafeArea:Bool {
        
        if #available(iOS 11.0, *) {
            if let topPadding = UIApplication.shared.currentWindow?.safeAreaInsets.top,
                topPadding > 0 {
                return true
            }
        }
        
        return false
    }
}

//MARK:- UIViewController

extension UIViewController{
    func showAlert(withMessage message:String, withActions actions: UIAlertAction... ,withStyle style:UIAlertController.Style = .alert) {
        
        let alert = UIAlertController(title: AppDisplayName, message: message, preferredStyle: style)
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK:- UIColor

extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let chars = Array(hexString.dropFirst())
                self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                          green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                          blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                          alpha: 1)}
}


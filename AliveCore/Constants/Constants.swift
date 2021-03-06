//
//  Constants.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import Foundation
import UIKit

enum InternetConnectionErrorCode: Int {
    case offline = 10101
}

//MARK:- Global Variables
let Application                         = UIApplication.shared.delegate as! AppDelegate
var AppName: String {return Bundle.main.infoDictionary!["CFBundleName"] as! String}
var AppDisplayName: String {return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String}

var AppVersion: String {return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String}

var buildVersion: String {return Bundle.main.infoDictionary!["CFBundleVersion"] as! String}


//MARK:- UIDevice Static Constants

let IS_IPHONE_5             = 568.0
let IPHONE6_PLUS_WIDTH      = 414.0
let IPHONE6_PLUS_HEIGHT     = 736.0
let IPHONE6_WIDTH           = 375.0
let IPHONE6_HEIGHT          = 667.0
let IPHONEX_HEIGHT          = 812.0

let isIpad = UIDevice.current.userInterfaceIdiom == .pad

let Screen                  = UIScreen.main.bounds.size

let IMAGE_URL           = "https://image.tmdb.org/t/p/w200"
let BACK_IMAGE_URL      = "https://image.tmdb.org/t/p/w500"

var SAFE_AREA_NOTCH_INSET: CGFloat{
    if #available(iOS 11.0, *) {
        if let window = UIApplication.shared.currentWindow {
            let inset = window.safeAreaInsets
            return (inset.top ) +  (inset.bottom)
        }
        return 0
    }else{
        return 0
    }
}


//MARK:- Delay Methods
public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
    let dispatchTime = DispatchTime.now() + seconds
    dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
}

public enum DispatchLevel {
    case main, userInteractive, userInitiated, utility, background
    var dispatchQueue: DispatchQueue {
        switch self {
        case .main:                 return DispatchQueue.main
        case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
        case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
        case .utility:              return DispatchQueue.global(qos: .utility)
        case .background:           return DispatchQueue.global(qos: .background)
        }
    }
}

extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    }
}

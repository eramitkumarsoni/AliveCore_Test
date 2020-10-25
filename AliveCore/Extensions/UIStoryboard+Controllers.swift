//
//  UIStoryboard+Controllers.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import Foundation
import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

}


extension UIStoryboard {
    
    var moviesListViewController: MoviesListViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: MoviesListViewController.self)) as? MoviesListViewController else {
            fatalError(String(describing: MoviesListViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    
}

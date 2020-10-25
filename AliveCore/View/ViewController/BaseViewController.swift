//
//  BaseViewController.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class BaseViewController: UIViewController, AlerteableViewController, ActivityIndicatorViewable {

    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


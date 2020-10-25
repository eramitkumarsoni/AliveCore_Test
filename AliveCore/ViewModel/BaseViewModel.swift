//
//  BaseViewModel.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftMessages

class BaseViewModel {
    
    // Dispose Bag
    let disposeBag = DisposeBag()
    let alert = PublishSubject<(String, Theme)>()
    let alertDialog = PublishSubject<(String,String)>()
    
}

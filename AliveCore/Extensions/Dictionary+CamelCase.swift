//
//  Dictionary+CamelCase.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import Foundation



extension Dictionary {
    
    /// Underscore Keys to lowerCamelCase keys recursively.
    var keysToCamelCase: Dictionary {
        
        let keys = Array(self.keys)
        let values = Array(self.values)
        var dict: Dictionary = [:]
        
        keys.enumerated().forEach { (index, key) in
            
            var value = values[index]
            var keyCamelCased:Key = key
            
            if let v = value as? Dictionary, let v1 = v.keysToCamelCase as? Value {
                value = v1
            }
            
            if let k = key as? String, let k1 = k.underscoreToCamelCase as? Key {
                keyCamelCased = k1
            }
            
            dict[keyCamelCased] = value
        }
        
        return dict
    }
}

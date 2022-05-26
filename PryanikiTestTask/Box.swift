//
//  Box.swift
//  f1Project
//
//  Created by Valeriy Trusov on 04.05.2022.
//

import Foundation


class Box<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        
        didSet {
            
            listener?(value)
        }
    }
    
    func bind(needToReload: Bool, listener: @escaping Listener) {
        self.listener = listener
        
        if needToReload {
            
            listener(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
}

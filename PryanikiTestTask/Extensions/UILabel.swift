//
//  UILabel.swift
//  PryanikiTestTask
//
//  Created by Valeriy Trusov on 26.05.2022.
//

import Foundation
import UIKit


extension UILabel {
    
    static func createCustomLabel() -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        let description = UIFontDescriptor().withSymbolicTraits(.traitBold)
        label.font = UIFont(descriptor: description!, size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

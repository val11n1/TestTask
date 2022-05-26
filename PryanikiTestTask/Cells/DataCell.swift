//
//  DataCell.swift
//  PryanikiTestTask
//
//  Created by Valeriy Trusov on 26.05.2022.
//

import Foundation
import UIKit


class DataCell: BaseTableViewCell {
    
    override func setupView() {
        
        self.addSubview(nameLabel)
        self.addSubview(accessoryIndicator)
        NSLayoutConstraint.activate([
        
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width / 2),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            accessoryIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            accessoryIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            accessoryIndicator.widthAnchor.constraint(equalToConstant: 15),
            accessoryIndicator.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        self.backgroundColor = .clear
    }
    
    func configure(dataModel: DataModel) {
        
        nameLabel.text = dataModel.name
    }
}

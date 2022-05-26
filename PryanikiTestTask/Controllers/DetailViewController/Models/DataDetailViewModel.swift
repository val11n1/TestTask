//
//  DataDetailViewModel.swift
//  PryanikiTestTask
//
//  Created by Valeriy Trusov on 26.05.2022.
//

import Foundation
import UIKit

protocol DataDetailViewModelType {
    
    var name: String { get }
    var description: String { get }
    var imageURL: String? { get }
    var image: Box<UIImage?>? { get }
    
    func loadImage() 
}

struct DataDetailViewModel: DataDetailViewModelType {
    
    var dataFetcher: DataFetcherService = DataFetcherService()
    
    var name: String
    var description: String
    var imageURL: String?
    var image: Box<UIImage?>?
    
    func loadImage() {
       
        dataFetcher.downloadImageFrom(url: imageURL!) { data in
            
            if let data = data {
                
                let image = UIImage(data: data)
                self.image!.value = image
                
            }else {
                
                self.image!.value = nil
                
            }
        }
    }
}

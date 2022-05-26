//
//  RequestDataModel.swift
//  PryanikiTestTask
//
//  Created by Valeriy Trusov on 26.05.2022.
//

import Foundation


struct RequestDataModel: Codable {
    
    let data: [Object]
    let view: [String]
}

struct Object: Codable {
    
    var name: String
    var data: ObjectData
}

struct ObjectData: Codable {
    
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variant]?
}

struct Variant: Codable {
    
    var id: Int
    var text: String
}

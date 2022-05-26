//
//  DataViewModel.swift
//  PryanikiTestTask
//
//  Created by Valeriy Trusov on 26.05.2022.
//

import Foundation


protocol DataViewModelType {
    
    static func loadJSONData(completion: @escaping (DataViewModel?) -> Void)
    static func createDataViewModel(requestModel: RequestDataModel) -> DataViewModel
    func numberOfRows() -> Int
    func dataModelFrom(index: Int) -> DataModel?
    func createDataDetailModelFrom(index: Int) -> DataDetailViewModel?
}

class DataViewModel: DataViewModelType {
    
    static var dataFetcherService: DataFetcherService = DataFetcherService()
    
    private var dataModelsArray: [DataModel]
    
    private enum ObjectNames: String {
        case HZ = "hz"
        case Picture = "picture"
        case Selector = "selector"
    }
    
    init(dataModelsArray: [DataModel]) {
        self.dataModelsArray = dataModelsArray
        
    }
    
    static func loadJSONData(completion: @escaping (DataViewModel?) -> Void) {
        
        dataFetcherService.fetchData { data in
            
            guard let data = data else {
                completion(nil)
                return
            }
            let viewModel = self.createDataViewModel(requestModel: data)
            completion(viewModel)
        }
    }
    
    static func createDataViewModel(requestModel: RequestDataModel) -> DataViewModel {
        
        let requestObjects = requestModel.data
        var dataModelDict: [String:DataModel] = [:]
        
        for object in requestObjects {
            
            let name = object.name
            let text = object.data.text
            let url = object.data.url
            var variant: Variant!
            
            if let variants = object.data.variants {
                
                for dataVariant in variants {
                    
                    if dataVariant.id == object.data.selectedId {
                        variant = dataVariant
                    }
                }
            }
            let newDataModel = DataModel(name: name, text: text, url: url, variant: variant)
            dataModelDict[newDataModel.name] = newDataModel
        }
        
        var resultDataModelArray: [DataModel] = []
        
        for objectName in requestModel.view {
            
            resultDataModelArray.append(dataModelDict[objectName]!)
        }
        
        return DataViewModel(dataModelsArray: resultDataModelArray)
    }
    
    func numberOfRows() -> Int {
        
        return dataModelsArray.count
    }
    
    func dataModelFrom(index: Int) -> DataModel? {
        
        return dataModelsArray[index]
    }
    
    func createDataDetailModelFrom(index: Int) -> DataDetailViewModel? {
        
        let dataModel = dataModelsArray[index]
        if let name = ObjectNames(rawValue: dataModel.name) {
        
            switch name {
        
            case .HZ:
                let description = "text: \(dataModel.text!)"
                return DataDetailViewModel(name: "name: \(name.rawValue)", description: description)
                
            case .Picture:
                let description = "text: \(dataModel.text!)"
                let imageUrl = dataModel.url
                return DataDetailViewModel(name: "name: \(name.rawValue)", description: description, imageURL: imageUrl!, image: Box(value: nil))
                
            case .Selector:
                
                let description = "id: \(dataModel.variant!.id), text: \(dataModel.variant!.text)"
                return DataDetailViewModel(name: name.rawValue, description: description)
            }
        }
        return nil
    }
}

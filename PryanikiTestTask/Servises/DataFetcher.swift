//
//  DataFetcher.swift
//  f1Project
//
//  Created by Valeriy Trusov on 03.05.2022.
//

import Foundation


protocol DataFetcher {
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, responce: @escaping (T?) -> Void)
}


class NetworkingDataFetcher: DataFetcher {
    
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, responce: @escaping (T?) -> Void) {
        
        networking.request(urlString: urlString) { data, error in
            
            if let error = error {
                print(error.localizedDescription)
                responce(nil)
            }
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            responce(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            
            let objects = try decoder.decode(type.self, from: data)
            
            return objects
            
        }catch let jsonError {
            
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}

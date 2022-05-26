//
//  NetworkService.swift
//  f1Project
//
//  Created by Valeriy Trusov on 03.05.2022.
//

import Foundation
import UIKit


protocol Networking {
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}


class NetworkService: Networking {
    
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { data, responce, error in
            
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}

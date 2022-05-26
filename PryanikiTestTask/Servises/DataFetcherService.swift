//
//  DataFetcherService.swift
//  f1Project
//
//  Created by Valeriy Trusov on 03.05.2022.
//

import Foundation


class DataFetcherService {
    
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkingDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
//    func fetchDrivers(completion: @escaping (DriverStandings?) -> Void) {
//        
//        let urlString = "http://ergast.com/api/f1/current/driverStandings.JSON"
//        
//        dataFetcher.fetchGenericJSONData(urlString: urlString, responce: completion)
//        }

    func fetchData() {
        
        let urlString = "https://pryaniky.com/static/json/sample.json"
        dataFetcher.fetchGenericJSONData(urlString: urlString) { data in
            print(data)
        }
    }
    
}


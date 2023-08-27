//
//  FetchData.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 11-08-23.
//

import Foundation
import Alamofire

enum Status {
    case idle
    case success
    case errorFetch(Error)
    case errorDecode(Error)
}

class APIRequest: Fetchable {
    public func fetchData<T>(url: String, model: T.Type, completion: @escaping (T?, Bool, Status) -> Void) where T : Decodable {
        var requestStatus: Status = .idle
        
        AF.request(url, method: .get, encoding: URLEncoding.default).response { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(model.self, from: data!)
                    requestStatus = .success
                    completion(result, true, requestStatus)
                } catch let decodeError {
                    requestStatus = .errorDecode(decodeError)
                    completion(nil, true, requestStatus)
                }
                
            case .failure(let error):
                requestStatus = .errorFetch(error)
                completion(nil, true, requestStatus)
            }
        }
    }
}

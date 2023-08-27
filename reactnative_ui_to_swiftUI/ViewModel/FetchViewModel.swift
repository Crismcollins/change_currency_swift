//
//  FetchViewModel.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 17-08-23.
//

import Foundation

class FetchViewModel: ObservableObject {
    @Published var data: CurrencyList?
    
    public func findURL(currency: String) -> String {
        var currentCurrency: APIEndpoint
        
        switch currency {
        case "dolar":
            currentCurrency = .dolar
        case "euro":
            currentCurrency = .euro
        case "uf":
            currentCurrency = .uf
        case "utm":
            currentCurrency = .utm
        case "ipc":
            currentCurrency = .ipc
        default:
            currentCurrency = .dolar
        }
        
        return APIEndpoint.getURL(currency: currentCurrency)
    }
    
    public func fetchData<T:Decodable>(currency: String, model: T.Type, completion: @escaping(T?, Bool, Status) -> Void) {
        let apiRequest = APIRequest()
        let url = self.findURL(currency: currency)
        let _: () = apiRequest.fetchData(url: url, model: model) { result, finished, status in
            completion(result, finished, status)
        }
    }
    
    public func fetchDataAsync<T: Decodable>(currency: String, model: T.Type) async throws -> T {
        let url = URL(string: self.findURL(currency: currency))!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let dataModel = try! JSONDecoder().decode(model.self, from: data)
        return dataModel
    }
}

//
//  ValiesListViewModel.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 10-08-23.
//

import Foundation

class ValuesListViewModel: ObservableObject {
    @Published var currencys: [Currency] = []
    @Published var isLoading = true
    @Published var data: CurrencyList?
    private let fetchViewModel = FetchViewModel()
    
    func loading(_ loading: Bool) {
        self.isLoading = loading
    }
    
    public func getCurrencySymbol(_ currency: String) -> String {
        return currency == "ipc" ? "%" : "$"
    }
    
    public func isIPC(currency: String) -> Bool {
        return currency == "ipc"
    }
    
    public func fetchData(currency: String) {
        let _: () = fetchViewModel.fetchData(currency: currency, model: CurrencyList.self) { result, finished, status in
            switch status {
            case .success:
                self.data = result
            case .errorDecode:
                print("Error decode")
            case .errorFetch:
                print("Error connection")
            case .idle:
                print("Waiting data...")
            }
            
            self.loading(!finished)
        }
    }
    
    public func removeWhiteSpace(_ string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "")

    }
}

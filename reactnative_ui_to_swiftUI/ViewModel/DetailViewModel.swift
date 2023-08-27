//
//  DetailViewModel.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 16-08-23.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var symbolCurrency: SymbolCurrency = .dolar
    @Published var data: CurrencyList?
    @Published var valueMostUpdated: Currency?
    @Published var isLoading = true
    private let fetchViewModel = FetchViewModel()
    
    
    enum SymbolCurrency {
        case dolar
        case percent
        
        var symbol: String {
                switch self {
                case .dolar:
                    return "$"
                case .percent:
                    return "%"
                }
            }
    }
    
    public func setCurrency(currency: String) {
        switch currency {
        case "ipc":
            symbolCurrency = .percent
            
        default:
            symbolCurrency = .dolar
        }
    }
    
    public func getCurrency() -> String {
        return symbolCurrency.symbol
    }
    
    private func getMostUpdatedValue() {
        valueMostUpdated = data!.getMostUpdatedValue()
    }
    
    public func getTenMostUpdated() -> [Currency] {
        return data!.getFirstValues(from: 10).reversed()
    }
    
    public func fetchData(currency: String) {
        let _: () = fetchViewModel.fetchData(currency: currency, model: CurrencyList.self) { result, finished, status in
            switch status {
            case .success:
                self.data = result
                self.getMostUpdatedValue()
            case .errorDecode:
                print("Error decode")
            case .errorFetch:
                print("Error connection")
            case .idle:
                print("Waiting data...")
            }
            
            self.isLoading = !finished
            
        }
    }
    
    public func fetchDataAsync(currency: String) async {
        let dataAsync = try! await fetchViewModel.fetchDataAsync(currency: currency, model: CurrencyList.self)
        let specificData = dataAsync.currency.map { $0.Valor }
        print(specificData)
    }
}

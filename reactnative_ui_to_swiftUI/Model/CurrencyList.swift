//
//  CurrencyList.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 10-08-23.
//

import Foundation

struct CurrencyList: Codable {
    var currency: [Currency]
    
    enum CodingKeys: String, CodingKey {
        case currency
    }
    
    init() {
        self.currency = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var currencies: [Currency] = []
        
        for key in container.allKeys {
            
            if let decodedCurrencies = try? container.decode([Currency].self, forKey: key) {
                currencies = decodedCurrencies
                break
            }
        }
        
        currency = currencies
    }
    
    public func orderedMostCurrent() -> [Currency] {
        return currency.reversed()
    }
    
    public func getMostUpdatedValue() -> Currency {
        let currencyOrdered = orderedMostCurrent()
        return currencyOrdered[0]
    }
    
    public func getFirstValues(from value: Int) -> [Currency] {
        return Array(currency.reversed().prefix(value))
    }
    
}

// DynamicCodingKeys is a helper struct to handle dynamic coding keys
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}

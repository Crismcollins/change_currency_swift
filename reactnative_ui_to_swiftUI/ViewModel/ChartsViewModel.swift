//
//  ChartsViewModel.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 22-08-23.
//

import Foundation
import Charts

class ChartsViewModel: ObservableObject {
    @Published var ticksY: [Double] = []
    public var minStickY: Int = 0
    public var maxStickY: Int = 0
    private let ticksAmount: Double = 5
    private var offsetTicksY: Double = 25
    
    public var minStickYValue: Double = 0
    public var maxStickYValue: Double = 0
    
    public func convertStringValueToDouble(_ value: String) -> Double{
        if let valueConverted = Double(value) {
            return valueConverted
        }
        else {
            let stringValueWithDot = value.replacingOccurrences(of: ",", with: ".")
            if let valueConverted2 = Double(stringValueWithDot) {
                return valueConverted2
            } else {
                let stringValueWithDotComma = value.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
                if let doubleValue = Double(stringValueWithDotComma) {
                    return doubleValue
                } else {
                    return 0.0
                }
            }
        }
    }
    
    private func getValuesArray(_ dataArray: [Currency]) -> [Double] {
        return dataArray.map { convertStringValueToDouble($0.Valor) }
    }
    
    private func getMaxValue(_ data: [Currency]) -> Double {
        let values = getValuesArray(data)
        return values.max()!
    }
    
    private func getMinValue(_ data: [Currency]) -> Double {
        let values = getValuesArray(data)
        return values.min()!
    }
    
    private func calculateOffset(_ data: [Currency]) {
        let minValue = getMinValue(data)
        let maxValue = getMaxValue(data)
        offsetTicksY = Double(maxValue - minValue) / (ticksAmount - 1)
    }
    
    public func generateTicksY(data: [Currency]) {
        calculateOffset(data)
        let minValue = getMinValue(data)
        let ticksAmountInt = Int(ticksAmount)
        var currentValue: Double = 0.0
        
        for i in 0..<ticksAmountInt {
            
            switch i {
            case 0:
                currentValue = minValue - offsetTicksY
            case ticksAmountInt - 1:
                currentValue = minValue + (offsetTicksY * Double(i + 2))
            default:
                currentValue = minValue + (offsetTicksY * Double(i))
            }
            
            ticksY.append(currentValue)
        }
    }
    
    public func getMaxTickY() -> Double {
        return ticksY.max()!
    }
    
    public func getMinTickY() -> Double {
        return ticksY.min()!
    }
    
    public func setFormatDate(_ date: String) -> String{
        return String(date.suffix(5))
    }
    
    public func setValueWithSymbol(value: Int ,currency: String) -> String {
        if currency == "dolar" || currency == "euro" {
            return "$\(value)"
        }
        else if currency == "ipc" {
            return "\(value)%"
        }
        else if currency == "utm" || currency == "uf" {
            return "\(value)k"
        }
        else
        {
            return "$\(value)"
        }
    }
    
    public func setSymbolValueOnChart(value: String, currency: String) -> String {
        if currency == "ipc" {
            return "\(value)%"
        } else {
            return "$\(value)"
        }
    }
}

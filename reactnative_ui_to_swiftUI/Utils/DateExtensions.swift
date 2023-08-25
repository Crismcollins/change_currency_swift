//
//  DateExtensions.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 08-08-23.
//

import Foundation

public struct DateComponent {
    var day: Int
    var month: Int
    var year: Int
}

enum DateValidationError: Error {
    case invalidDate
}

extension Date {
    func getPreviousMonth(currentDate: Date) -> Date {
        let calendar = Calendar.current
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: currentDate)!
        let day = calendar.component(.day, from: currentDate)
        
        if let lastDayOfPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)?.upperBound,
           day <= lastDayOfPreviousMonth {
            return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: previousMonth)!
        } else {
            let daysToAdd = calendar.range(of: .day, in: .month, for: currentDate)!.count - day + 1
            return calendar.date(byAdding: .day, value: -daysToAdd, to: currentDate)!
        }
    }
    
    public func getComponentsDate(date: Date) -> DateComponent {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        return DateComponent(day: components.day!, month: components.month!, year: components.year!)
    }
}

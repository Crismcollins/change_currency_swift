//
//  APIEndpoint.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 08-08-23.
//

import Foundation

enum APIEndpoint {
    case dolar
    case euro
    case utm
    case ipc
    case uf
    
    private var currentDate: Date { Date() }
    private var previousMonthDate: Date { currentDate.getPreviousMonth(currentDate: currentDate) }
    private var currentDateComponents: DateComponent { currentDate.getComponentsDate(date: currentDate) }
    private var PreviousMonthDateComponents: DateComponent { currentDate.getComponentsDate(date: previousMonthDate) }
    
    private static var baseURL: String { "https://api.cmfchile.cl/api-sbifv3/recursos_api" }
    private var format: String { "json" }
    
    private var apikey: String {
        guard let apikey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API key not found in environment variables.")
        }
        return apikey
    }
    
    private var path: String {
        switch self {
        case .dolar:
            return "/dolar/periodo/\(PreviousMonthDateComponents.year)/\(PreviousMonthDateComponents.month)/dias_i/\(PreviousMonthDateComponents.day)/\(currentDateComponents.year)/\(currentDateComponents.month)/dias_f/\(currentDateComponents.day)/?apikey=\(apikey)&formato=\(format)"
        case .euro:
            return "/euro/posteriores/\(PreviousMonthDateComponents.year)/\(PreviousMonthDateComponents.month)/dias/\(PreviousMonthDateComponents.day)?apikey=\(apikey)&formato=\(format)"
        case .utm:
            return "/utm/\(currentDateComponents.year)?apikey=\(apikey)&formato=\(format)"
        case .ipc:
            return "/ipc/\(currentDateComponents.year)?apikey=\(apikey)&formato=\(format)"
        case .uf:
            return "/uf/periodo/\(PreviousMonthDateComponents.year)/\(PreviousMonthDateComponents.month)/\(currentDateComponents.year)/\(currentDateComponents.month)?apikey=\(apikey)&formato=\(format)"
        }
    }
    
    public static func getURL(currency: APIEndpoint) -> String {
        return baseURL + currency.path
    }
    
}

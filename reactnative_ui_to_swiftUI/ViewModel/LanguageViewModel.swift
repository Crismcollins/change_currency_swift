//
//  LanguageViewModel.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 16-08-23.
//

import Foundation

class LanguageViewModel: ObservableObject {
    @Published var data: [String: String] = [:]
    
    init() {
        if let plistPath = Bundle.main.path(forResource: "Language", ofType: "plist"),
           let plistData = NSDictionary(contentsOfFile: plistPath) as? [String: String] {
            data = plistData
        }
    }
    
    public func getText(_ key: String) -> String {
        return self.data[key] ?? errorMsge(key: key)
    }
    
    private func errorMsge(key: String) -> String {
        return "\(key) not found in language file."
    }
}

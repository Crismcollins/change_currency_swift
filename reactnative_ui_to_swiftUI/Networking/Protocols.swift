//
//  Protocols.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 11-08-23.
//

import Foundation

protocol Fetchable {
    func fetchData<T: Decodable>(
            url: String,
            model: T.Type,
            completion: @escaping (T?, Bool, Status) -> Void
        )
}

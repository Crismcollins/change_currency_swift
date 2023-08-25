//
//  Currency.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 08-08-23.
//

import Foundation

struct Currency: Codable, Hashable {
    let Valor: String
    let Fecha: String
    
    init(valor: String, fecha: String) {
        self.Valor = valor
        self.Fecha = fecha
    }
}

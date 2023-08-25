//
//  CurrencyCard.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 07-08-23.
//

import SwiftUI

struct CurrencyCard: View {
    @EnvironmentObject var language: LanguageViewModel
    var currency:String
    @Binding var path: [String]
    @Binding var currentCurrency: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(language.getText(currency))
                    .bold()
                    .font(.system(size: 24))
                
                Text(language.getText(currencyLanguage(currency)))
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "info.circle")
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(alignment: .trailing)
                .highPriorityGesture(TapGesture().onEnded {
                    currentCurrency = currency
                    path.append("2")
                })
        }
        .contentShape(Rectangle())
        .onTapGesture {
            currentCurrency = currency
            path.append("1")
        }
    }
    
    private func currencyLanguage(_ currency: String) -> String {
        return currency == "ipc" ? "percent" : "pesos"
    }
}

struct CurrencyCard_Previews: PreviewProvider {
    static var previews: some View {
        let language = LanguageViewModel()
        
        let binding = Binding<[String]>(
            get: { ["1","2"] },
            set: { _ in }
        )
        let bindingCurrency = Binding<String>(
            get: { "Dolares" },
            set: { _ in }
        )
        
        CurrencyCard(currency: "dolar", path: binding, currentCurrency: bindingCurrency)
            .environmentObject(language)
    }
}

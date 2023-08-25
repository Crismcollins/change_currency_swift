//
//  ValuesListView.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 07-08-23.
//

import SwiftUI

struct ValuesListView: View {
    @EnvironmentObject var language: LanguageViewModel
    @StateObject private var viewModel = ValuesListViewModel()
    @Binding public var currency: String
    
    
    var body: some View {
        VStack {
            if (viewModel.isLoading){
                CustomProgressView()
            } else {
                List(viewModel.data?.orderedMostCurrent() ?? [], id: \.self) { currency in
                    HStack {
                        Text(currency.Fecha)
                            .frame(maxWidth: 100)
                        Spacer()
                        if viewModel.isIPC(currency: self.currency) {
                            Text("\(currency.Valor) \(viewModel.getCurrencySymbol(self.currency))")
                        } else {
                            Text("\(viewModel.getCurrencySymbol(self.currency)) \(currency.Valor)")
                                .frame(maxWidth: 100, alignment: .leading)
                        }
                        
                    }
                }
                .navigationTitle(language.getText(currency))
                .frame(alignment: .trailing)
                .listStyle(.inset)
            }
            
        }
        .onAppear {
            if viewModel.data == nil {
                viewModel.fetchData(currency: currency)
            }
        }
    }
}

struct ValuesListView_Previews: PreviewProvider {
    static var previews: some View {
        let language = LanguageViewModel()
        let bindingCurrency = Binding<String>(
            get: { "Dolares" },
            set: { _ in }
        )
        ValuesListView(currency: bindingCurrency)
            .environmentObject(language)
    }
}

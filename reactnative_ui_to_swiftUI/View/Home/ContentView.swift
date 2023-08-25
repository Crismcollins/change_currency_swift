//
//  ContentView.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 07-08-23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var language: LanguageViewModel
    @State private var path: [String] = []
    @State private var currentCurrency: String = ""
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ZStack{
                    
                    List(viewModel.currencyList, id: \.self) { currency in
                        CurrencyCard(currency: currency, path: $path, currentCurrency: $currentCurrency)
                    }
                    .navigationTitle(language.getText("currencies"))
                    .listStyle(.plain)
                    .navigationDestination(for: String.self) { value in
                        if (value == "1"){
                            ValuesListView(currency: $currentCurrency)
                        }
                        else if (value == "2"){
                            DetailView(currency: $currentCurrency)
                        }
                    }
                }
                
            }.navigationBarTitleDisplayMode(.inline)
        }
        .tint(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let language = LanguageViewModel()
        ContentView(viewModel: HomeViewModel())
            .environmentObject(language)
    }
}

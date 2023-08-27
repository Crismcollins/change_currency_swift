//
//  DetailView.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 07-08-23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var language: LanguageViewModel
    @StateObject private var viewModel = DetailViewModel()
    @Binding var currency: String
    
    var body: some View {
        VStack{
            
            if (viewModel.isLoading){
                CustomProgressView()
            } else {
                ZStack {
                    VStack(alignment: .leading, spacing: 6) {
                        if viewModel.symbolCurrency == .dolar {
                            Text("1 \(language.getText(currency)) \(language.getText("equal_to"))")
                                .bold()
                                .font(.headline)
                        } else {
                            Text("\(language.getText(currency)) \(language.getText("equal_to_ipc"))")
                                .bold()
                                .font(.headline)
                        }
                        
                        
                        HStack(spacing: 2){
                            if (viewModel.symbolCurrency == .dolar){
                                Text("\(viewModel.symbolCurrency.symbol) \(viewModel.valueMostUpdated?.Valor ?? language.getText("loading"))")
                                    .font(.title)
                                Text(language.getText("clp"))
                                    .font(.headline)
                                    .offset(y:2)
                            }
                            else if (viewModel.symbolCurrency == .percent){
                                Text(viewModel.valueMostUpdated?.Valor ?? language.getText("loading"))
                                    .font(.title)
                                Text(viewModel.getCurrency())
                            }
                        }
                        .bold()
                        
                        Text("\(language.getText("last_update")) \(viewModel.valueMostUpdated?.Fecha ?? language.getText("loading"))")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .bold()
                    }
                    .padding(16)
                    .frame(width: 360, alignment: .leading)
                    .background(.white)
                    .foregroundColor(.blue)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x:4, y:5)
                    .offset(y: 35)
                }
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                
                Spacer()

                VStack {
                    LineChart(data: viewModel.getTenMostUpdated(), currency: currency)
                }
                .offset(y: 40)
                
                
            }
        }
        .navigationTitle(language.getText(currency))
        .onAppear {
            viewModel.setCurrency(currency: currency)
            viewModel.fetchData(currency: currency)
            Task {
                await viewModel.fetchDataAsync(currency: currency)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let language = LanguageViewModel()
        let bindingCurrency = Binding<String>(
            get: { "dolar" },
            set: { _ in }
        )
        
        DetailView(currency: bindingCurrency)
            .environmentObject(language)
    }
}

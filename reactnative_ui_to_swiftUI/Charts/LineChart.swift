//
//  LineChart.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 18-08-23.
//

import SwiftUI
import Charts

struct LineChart: View {
    @State var dataArray: [Currency]
    @ObservedObject private var viewModel = ChartsViewModel()
    private var currency: String
    
    init(data: [Currency], currency: String) {
        self.dataArray = data
        self.currency = currency
        viewModel.generateTicksY(data:dataArray)
    }
    
    var body: some View {
        Chart(dataArray, id: \.self) {
            let currency = $0
            
            LineMark(
                x: .value("Fechas", $0.Fecha),
                y: .value("Valor", viewModel.convertStringValueToDouble($0.Valor))
            )
            .foregroundStyle(.blue)
            
            AreaMark(
                x: .value("Fechas", $0.Fecha),
                yStart: .value("start", viewModel.convertStringValueToDouble($0.Valor)),
                yEnd: .value("end", Double(viewModel.getMinTickY()))
            )
            .foregroundStyle(.blue)
            .opacity(0.3)
            
            
            PointMark(
                x: .value("Fechas", $0.Fecha),
                y: .value("Valor", viewModel.convertStringValueToDouble($0.Valor))
            )
            .foregroundStyle(.blue)
            .annotation(position: .overlay, alignment: .bottom) {
                Text(viewModel.setSymbolValueOnChart(value: String(currency.Valor), currency: self.currency))
                    .foregroundColor(.red)
                    .bold()
                    .font(.system(size:14))
            }
        }
        .padding(.init(top: 30, leading: 6, bottom: 16, trailing: 24))
        .chartYScale(domain: viewModel.getMinTickY()...viewModel.getMaxTickY())
        .chartYAxis {
            AxisMarks(
                position: .leading,
                values: viewModel.ticksY
            ) { value in
                AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                    .foregroundStyle(Color.green)
                
                AxisValueLabel() {
                    if let intValue = value.as(Int.self) {
                        Text(viewModel.setValueWithSymbol(value: intValue, currency: currency))
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks { value in
                
                AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                    .foregroundStyle(Color.green)
                
                AxisValueLabel() {
                    if let stringValue = value.as(String.self) {
                        Text("\(viewModel.setFormatDate(stringValue))")
                            .rotationEffect(Angle(degrees: -60))
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 200)
                    }
                }
            }
        }
        
        
//        .chartXAxisLabel(alignment: .center) {
//            Text("Fechas")
//                .font(.system(size: 18))
//                .foregroundColor(.black)
//                .bold()
//                .offset(y: 24)
//        }
//        .chartYAxisLabel(position: .leading, alignment: .center) {
//            Text("Valores")
//                .font(.system(size: 18))
//                .foregroundColor(.black)
//                .bold()
//        }
    }
}
    
struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        let testData = [
            Currency(valor: "869,51", fecha: "2023-08-22"),
            Currency(valor: "867,95", fecha: "2023-08-21"),
            Currency(valor: "864,72", fecha: "2023-08-18"),
            Currency(valor: "859,87", fecha: "2023-08-17"),
            Currency(valor: "859,03", fecha: "2023-08-16")
        ]
        
        LineChart(data: testData, currency: "dolar")
    }
}

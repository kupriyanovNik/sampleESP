//
//  ChartView.swift
//  sampleESP
//
//  Created by Никита on 18.02.2023.
//

import SwiftUI

struct ChartView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var value1: Int
    @Binding var value2: Int
    var name: String
    var description: String
    let gradient: Gradient
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.gray.opacity(0.5))
            HStack {
                Gauge(value: Float(value1 + value2) / 200.0, in: 0...1) {
                    
                } currentValueLabel: {
                    Text("\(Int(value1 + value2)/2)")
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                } minimumValueLabel: {
                    Text("0")
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                } maximumValueLabel: {
                    Text("100")
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
                .padding(.leading, 15)
                .tint(gradient)
                .gaugeStyle(.accessoryCircular)
                Spacer()
                VStack {
                    Text(name)
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
                .padding(.trailing, 15)
                .frame(width: 200)
            }
            .padding(.horizontal, 15)

        }
        .frame(width: 350, height: 100, alignment: .center)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(value1: .constant(55), value2: .constant(65), name: "Влажность", description: "Cодержание молекул воды в воздухе", gradient: Gradient(colors: [
            .red.opacity(0.8),
            .yellow.opacity(0.8),
            .green.opacity(0.8),
            .yellow.opacity(0.8),
            .red.opacity(0.8)
        ]))
            .previewLayout(.sizeThatFits)
    }
}

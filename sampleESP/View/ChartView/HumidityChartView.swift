//
//  HumidityChartView.swift
//  sampleESP
//
//  Created by Никита on 18.02.2023.
//

import SwiftUI

struct HumidityChartView: View {
    @EnvironmentObject var model: ViewModel
    var name: String = "Влажность"
    var description: String = "Cодержание молекул воды в воздухе"
    var body: some View {
        NavigationLink {
            HumiditySelectView()
                .environmentObject(model)
                .navigationTitle("Влажность: \(Int( (model.main[1] + model.main[5]) / 2 ))%")
        } label: {
            ChartView(value1: $model.main[1], value2: $model.main[5], name: name, description: description, gradient: Gradient(colors: [
                .red.opacity(0.8),
                .yellow.opacity(0.8),
                .green.opacity(0.8),
                .yellow.opacity(0.8),
                .red.opacity(0.8)
            ]))
        }

    }
}

struct HumidityChartView_Previews: PreviewProvider {
    static var previews: some View {
        HumiditySelectView()
            .environmentObject(ViewModel())
            .previewLayout(.sizeThatFits)
    }
}

struct HumiditySelectView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .frame(height: 250, alignment: .center)
                VStack {
                    Text("Текущая влажность, измеренная первым датчиком: \(model.main[1])%")
                        .multilineTextAlignment(.center)
                    Divider()
                    Text("Текущая влажность, измеренная вторым датчиком: \(model.main[5])%")
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
            if model.selectedPlant == .undefined {
                HStack {
                    Text("Увлажнитель включится, если средняя влажность меньше \(model.values[1])")
                    Stepper("", value: $model.values[1], in: 0...100, step: 1)
                }
            }
            Spacer()
            Text("Влажность измеряется в процентах двумя датчиками DHT11 и DHT22")
                .opacity(0.7)
                .multilineTextAlignment(.center)
        }
        .onChange(of: model.values[1], perform: { newValue in
            model.send("Values/humi", value: model.values[1])
        })
        .padding(.horizontal, 25)
        .padding(.vertical, 50)
    }
}

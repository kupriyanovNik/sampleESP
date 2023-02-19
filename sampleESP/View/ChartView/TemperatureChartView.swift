//
//  TemperatureChartView.swift
//  sampleESP
//
//  Created by Никита on 18.02.2023.
//


import SwiftUI

struct TemperatureChartView: View {
    @EnvironmentObject var model: ViewModel
    var name: String = "Температура"
    var description: String = "Степень нагретости воздуха"
    var body: some View {
        NavigationLink {
            TemperatureSelectView()
                .environmentObject(model)
                .navigationTitle("Температура: \(Int( (model.main[2] + model.main[6]) / 2 ))°")
        } label: {
            ChartView(value1: $model.main[2], value2: $model.main[6], name: name, description: description, gradient: Gradient(colors: [
                .yellow.opacity(0.8),
                .green.opacity(0.8),
                .green.opacity(0.8),
                .yellow.opacity(0.8),
                .red.opacity(0.8)
            ]))
        }

    }
}

struct TemperatureChartView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureSelectView()
            .environmentObject(ViewModel())
            .previewLayout(.sizeThatFits)
    }
}

struct TemperatureSelectView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .frame(height: 250, alignment: .center)
                VStack {
                    Text("Текущая температура, измеренная первым датчиком: \(model.main[2])°C")
                        .multilineTextAlignment(.center)
                    Divider()
                    Text("Текущая температура, измеренная вторым датчиком: \(model.main[6])°C")
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
            if model.selectedPlant == .undefined {
                HStack {
                    Text("Форточка откроется, если средняя температура меньше \(model.values[2])")
                    Stepper("", value: $model.values[2], in: 0...100, step: 1)
                }
            }
            Spacer()
            Text("Температура измеряется в градусах Цельсия двумя датчиками DHT11 и DHT22")
                .opacity(0.7)
                .multilineTextAlignment(.center)
        }
        .onChange(of: model.values[2], perform: { newValue in
            model.send("Values/temp", value: model.values[2])
        })
        .padding(.horizontal, 25)
        .padding(.vertical, 50)
    }
}

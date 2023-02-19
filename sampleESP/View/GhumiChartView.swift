//
//  GhumiChartView.swift
//  sampleESP
//
//  Created by Никита on 18.02.2023.
//

import SwiftUI

struct GhumiChartView: View {
    @EnvironmentObject var model: ViewModel
    var name: String = "Вл. почвы"
    var description: String = "Cодержание молекул воды в земле"
    var body: some View {
        NavigationLink {
            GhumiSelectView()
                .environmentObject(model)
                .navigationTitle("Вл. почвы: \(Int( (model.main[0] + model.main[4]) / 2 ))%")
        } label: {
            ChartView(value1: $model.main[0], value2: $model.main[4], name: name, description: description, gradient: Gradient(colors: [
                .red.opacity(0.8),
                .red.opacity(0.8),
                .green.opacity(0.8),
                .green.opacity(0.8),
                .yellow.opacity(0.8),
                .red.opacity(0.8)
            ]))
        }

    }
}

struct GhumiChartView_Previews: PreviewProvider {
    static var previews: some View {
        GhumiChartView()
            .environmentObject(ViewModel())
            .previewLayout(.sizeThatFits)
    }
}

struct GhumiSelectView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .frame(height: 250, alignment: .center)
                VStack {
                    Text("Текущая влажность почвы, измеренная первым датчиком: \(model.main[0])°C")
                        .multilineTextAlignment(.center)
                    Divider()
                    Text("Текущая влажность почвы, измеренная вторым датчиком: \(model.main[4])°C")
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
            HStack {
                Text("Водяной насос включится, если средняя влажность меньше \(model.values[0])")
                Stepper("", value: $model.values[0], in: 0...100, step: 1)
            }
            Spacer()
            Text("Влажность почвы измеряется в процентах двумя рандомными датчиками с али")
                .opacity(0.7)
                .multilineTextAlignment(.center)
        }
        .onChange(of: model.values[0], perform: { newValue in
            model.send("Values/ghumi", value: model.values[0])
        })
        .padding(.horizontal, 25)
        .padding(.vertical, 50)
    }
}

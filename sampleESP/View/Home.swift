//
//  Home.swift
//  sampleESP
//
//  Created by Nikita on 14.02.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase


struct Home: View {
    @EnvironmentObject var model: ViewModel
    
    private var ref = Database.database().reference()
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    

    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                
                HumidityChartView()
                    .environmentObject(model)
                TemperatureChartView()
                    .environmentObject(model)
                GhumiChartView()
                    .environmentObject(model)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if model.main[3] < 1000 {
                        withAnimation {
                            Circle()
                                .foregroundColor(Color.red)
                        }
                    } else {
                        withAnimation {
                            EmptyView()
                        }
                    }
                }
            }
            .animation(.linear, value: model.main)
            .navigationTitle("Теплица")
        }
        .tint(.black)
        .onReceive(timer) { new in
            model.fetchData()
            if model.selectedPlant != .undefined {
                model.fetchValues()
            }
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ViewModel())
    }
}


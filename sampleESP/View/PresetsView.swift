//
//  PresetsView.swift
//  sampleESP
//
//  Created by Никита on 19.02.2023.
//

import SwiftUI
import FirebaseDatabase


struct PresetsView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        NavigationStack {
            HStack {
                Text("Растение:")
                Picker("", selection: $model.selectedPlant) {
                    ForEach(SelectedPlant.allCases, id: \.self) { value in
                        Text(value.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }.navigationTitle("Пресеты")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            model.showInfo = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            model.toggleLamp()
                        } label: {
                            Image(systemName: "sun.max")
                        }

                    }
                }
                .sheet(isPresented: $model.showInfo) {
                    InfoView()
                }
        }
    }
}

struct PresetsView_Previews: PreviewProvider {
    static var previews: some View {
        PresetsView()
            .environmentObject(ViewModel())
    }
}


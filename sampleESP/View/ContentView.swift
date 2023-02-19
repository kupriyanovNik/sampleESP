//
//  ContentView.swift
//  sampleESP
//
//  Created by Никита on 14.02.2023.
//
import FirebaseDatabase
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        TabView {
            Home()
                .environmentObject(model)
                .tabItem {
                    Label("Теплица", systemImage: "house")
                }
            PresetsView()
                .environmentObject(model)
                .tabItem {
                    Label("Пресеты", systemImage: "leaf.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}


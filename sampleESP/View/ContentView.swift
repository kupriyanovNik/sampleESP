//
//  ContentView.swift
//  sampleESP
//
//  Created by Никита on 14.02.2023.
//
import FirebaseDatabase
import SwiftUI

struct ContentView: View {
    @StateObject var model = ViewModel()
    var body: some View {
        Home()
            .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


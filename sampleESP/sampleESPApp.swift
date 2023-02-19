//
//  sampleESPApp.swift
//  sampleESP
//
//  Created by Никита on 14.02.2023.
//
import Firebase
import SwiftUI

@main
struct sampleESPApp: App {
    @StateObject var model = ViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}

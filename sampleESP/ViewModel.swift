//
//  ViewModel.swift
//  sampleESP
//
//  Created by Никита on 18.02.2023.
//

import Foundation
import SwiftUI
import FirebaseDatabase

class ViewModel: ObservableObject {
    @Published(key: "main") var main: [Int] = [0, 0, 0, 0, 0, 0, 0]
    @Published(key: "values") var values: [Int] = [55, 55, 55]
    
    private let mainTuple: [Int: String] = [
        0: "Sensor1/ghumi",
        1: "Sensor1/humi",
        2: "Sensor1/temp",
        3: "Sensor1/wlevel",
        4: "Sensor2/ghumi",
        5: "Sensor2/humi",
        6: "Sensor2/temp"
    ]
    private let valuesTuple: [Int: String] = [
        0: "Values/ghumi",
        1: "Values/humi",
        2: "Values/temp"
    ]
    private var ref = Database.database().reference()
    
    func fetchData() {
        for (index, path) in mainTuple {
            fetch(index: index, path: path)
        }
    }
    private func fetch(index: Int, path: String) {
        ref.child(path).getData { error, snap in
            if let error {
                print(error.localizedDescription)
            }
            self.main[index] = snap?.value as! Int
            
        }
    }
    
    func fetchValues() {
        for (index, path) in valuesTuple {
            fetchV(index: index, path: path)
        }
    }
    
    private func fetchV(index: Int, path: String) {
        ref.child(path).getData { error, snap in
            if let error {
                print(error.localizedDescription)
            }
            self.values[index] = snap?.value as! Int
            
        }
    }
    
    func send(_ path: String, value: Int) -> Void {
        ref.child(path).setValue( value )
        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 5)
    }
    
}


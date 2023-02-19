//
//  Extensions.swift
//  sampleESP
//
//  Created by Никита on 18.02.2023.
//

import Foundation
import SwiftUI
import Combine


private var cancellables = [String: AnyCancellable]()

extension Published {
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink(receiveValue: { val in
            UserDefaults.standard.set(val, forKey: key)
        })
    }
}

extension Published where Value: RawRepresentable, Value.RawValue == String {
    init(wrappedValue defaultValue: Value, key: String) {
        let savedValue = UserDefaults.standard.string(forKey: key) ?? ""
        let value = Value.init(rawValue: savedValue) ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink(receiveValue: { val in
            UserDefaults.standard.set(val.rawValue, forKey: key)
        })
    }
}



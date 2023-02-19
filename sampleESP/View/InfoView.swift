//
//  InfoView.swift
//  sampleESP
//
//  Created by Никита on 20.02.2023.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                Link("github", destination: URL(string: "https://github.com/kupriyanovNik/sampleESP")!)
            }
            .navigationTitle("Информация")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

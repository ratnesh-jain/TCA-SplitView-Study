//
//  ContentView.swift
//  Plain-SplitView-Study
//
//  Created by Ratnesh Jain on 22/06/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            NavigationLink(value: HomePath.details) {
                Text("Open Details")
            }
        }
        .padding()
    }
}

//
//  LibraryView.swift
//  Plain-SplitView-Study
//
//  Created by Ratnesh Jain on 22/06/23.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        List {
            ForEach(Array(1...10), id: \.self) { item in
                Text("Library: \(item)")
            }
        }
    }
}


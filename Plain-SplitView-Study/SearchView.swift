//
//  SearchView.swift
//  Plain-SplitView-Study
//
//  Created by Ratnesh Jain on 22/06/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searches: [String] = []
    @State private var searchText: String = ""
    
    var body: some View {
        List {
            ForEach(searches, id: \.self) {
                Text($0)
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            searches.append(searchText)
            searchText = ""
        }
    }
}


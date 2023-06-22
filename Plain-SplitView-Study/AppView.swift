//
//  AppView.swift
//  Plain-SplitView-Study
//
//  Created by Ratnesh Jain on 22/06/23.
//

import SwiftUI

enum HomePath {
    case details
    case inspector
}

enum LibraryPath {
    case details
    case author
}

struct AppView: View {
    @State private var selection: TabItem?
    var items: [TabItem] = TabItem.allCases
    @State private var homePath: [HomePath] = []
    @State private var libraryPath: [LibraryPath] = []
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(items, id: \.id) { item in
                    item.label
                }
            }
        } detail: {
            if let selection = selection {
                switch selection {
                case .home:
                    NavigationStack(path: $homePath)  {
                        HomeView()
                            .navigationDestination(for: HomePath.self) { path in
                                switch path {
                                case .details:
                                    Text("Home Details")
                                case .inspector:
                                    Text("Home Inspector")
                                }
                            }
                    }
                case .library:
                    NavigationStack(path: $libraryPath) {
                        LibraryView()
                    }
                case .search:
                    NavigationStack {
                        SearchView()
                    }
                }
            }
        }
    }
}

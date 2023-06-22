//
//  TabItem.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import Foundation
import SwiftUI

enum TabItem: Equatable, Identifiable, CaseIterable {
    case home
    case library
    case search
    
    var id: Self { self }
}

extension TabItem {
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .library:
            return "building.columns"
        case .search:
            return "magnifyingglass"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .library:
            return "Library"
        case .search:
            return "Search"
        }
    }
    
    var label: some View {
        Label(title, systemImage: systemImage)
    }
}

//
//  AppFeature.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct AppFeature: Reducer {
    struct State: Equatable {
        var tabs: IdentifiedArrayOf<AppTabFeature.State>
        var tabItems: [AppTabFeature.State.ID] { tabs.map({$0.id}) }
        var selectedTab: AppTabFeature.State?
        
        init(tabs: IdentifiedArrayOf<AppTabFeature.State> = .init(uniqueElements: [.home(.init()), .library(.init()), .search(.init(searchText: "", searches: []))])) {
            self.tabs = tabs
            self.selectedTab = tabs.first
        }
    }
    
    enum Action: Equatable {
        case select(id: AppTabFeature.State.ID)
        case selectedTabAction(id: AppTabFeature.State.ID, action: AppTabFeature.Action)
        case selectedTab(AppTabFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .select(let id):
                state.selectedTab = state.tabs[id: id]
                return .none
            case .selectedTabAction:
                return .none
            case .selectedTab:
                state.tabs[id: state.selectedTab?.id ?? .home] = state.selectedTab
                return .none
            }
        }
        .forEach(\.tabs, action: /Action.selectedTabAction, element: {
            AppTabFeature()
        })
        .ifLet(\.selectedTab, action: /Action.selectedTab) {
            AppTabFeature()
        }
        ._printChanges()
    }
}

struct AppTabFeature: Reducer {
    enum State: Equatable, Identifiable {
        case home(HomeStackFeature.State)
        case library(LibraryStackFeature.State)
        case search(SearchFeature.State)
        
        var id: TabItem {
            switch self {
            case .home(let state):
                return state.id
            case .library(let state):
                return state.id
            case .search(let state):
                return state.id
            }
        }
    }
    
    enum Action: Equatable {
        case home(HomeStackFeature.Action)
        case library(LibraryStackFeature.Action)
        case search(SearchFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: /State.home, action: /Action.home) {
            HomeStackFeature()
        }
        Scope(state: /State.library, action: /Action.library) {
            LibraryStackFeature()
        }
        Scope(state: /State.search, action: /Action.search) {
            SearchFeature()
        }
    }
}

struct AppTabView: View {
    let store: StoreOf<AppTabFeature>
    
    var body: some View {
        SwitchStore(store) { state in
            switch state {
            case .home:
                CaseLet(/AppTabFeature.State.home, action: AppTabFeature.Action.home) { homeStore in
                    HomeNavigationStackView(store: homeStore)
                        .tag(TabItem.home)
                        .tabItem { TabItem.home.label }
                }
            case .library:
                CaseLet(/AppTabFeature.State.library, action: AppTabFeature.Action.library) { libraryStore in
                    LibraryNavigationStackView(store: libraryStore)
                        .tag(TabItem.library)
                        .tabItem { TabItem.library.label }
                }
            case .search:
                CaseLet(/AppTabFeature.State.search, action: AppTabFeature.Action.search) { searchStore in
                    SearchView(store: searchStore)
                        .tag(TabItem.search)
                        .tabItem { TabItem.search.label }
                }
            }
        }
    }
}

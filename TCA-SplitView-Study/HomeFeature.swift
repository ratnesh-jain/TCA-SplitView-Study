//
//  HomeFeature.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import Foundation

struct HomeStackFeature: Reducer {
    struct Path: Reducer {
        enum State: Equatable {
            case homeDetail(String)
            case homeInspector(String)
        }
        
        enum Action: Equatable {
            case homeDetail(String)
            case homeInspector(String)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.homeDetail, action: /Action.homeDetail) {
                EmptyReducer()
            }
            Scope(state: /State.homeInspector, action: /Action.homeInspector) {
                EmptyReducer()
            }
        }
    }
    
    struct State: Equatable, Identifiable {
        var home: HomeFeature.State
        var path: StackState<Path.State>
        var id: TabItem { .home }
        
        init(home: HomeFeature.State = .init(), path: StackState<Path.State> = .init()) {
            self.home = home
            self.path = path
        }
    }
    
    enum Action: Equatable {
        case home(HomeFeature.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.home, action: /Action.home) {
            HomeFeature()
        }
        Reduce { state, action in
            switch action {
            case .home(.delegate(.openDetail(let item))):
                state.path.append(.homeDetail(item))
                return .none
            case .home(.delegate(.openInspector(let item))):
                state.path.append(.homeInspector(item))
                return .none
            case .home:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}

struct HomeFeature: Reducer {
    struct State: Equatable, Identifiable {
        var items: [String]
        var id: TabItem { .home }
        
        init(items: [String] = Array(0...10).map{"Home: \($0)"}) {
            self.items = items
        }
    }
    
    enum Action: Equatable {
        case didTap(String)
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case openDetail(String)
            case openInspector(String)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTap(let item):
                if item.contains("1") {
                    return .send(.delegate(.openInspector(item)))
                }
                return .send(.delegate(.openDetail(item)))
            case .delegate:
                return .none
            }
        }
    }
}

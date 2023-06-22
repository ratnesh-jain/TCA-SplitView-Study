//
//  LibraryFeature.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import Foundation

struct LibraryStackFeature: Reducer {
    struct Path: Reducer {
        enum State: Equatable {
            case libraryDetail(String)
            case author(Int)
        }
        
        enum Action: Equatable {
            case libraryDetail(String)
            case author(Int)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.libraryDetail, action: /Action.libraryDetail) {
                EmptyReducer()
            }
            Scope(state: /State.author, action: /Action.author) {
                EmptyReducer()
            }
        }
    }
    
    struct State: Equatable, Identifiable {
        var library: LibraryFeature.State
        var path: StackState<Path.State>
        var id: TabItem { .library }
        
        init(library: LibraryFeature.State = .init(), path: StackState<Path.State> = .init()) {
            self.library = library
            self.path = path
        }
    }
    
    enum Action: Equatable {
        case library(LibraryFeature.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.library, action: /Action.library) {
            LibraryFeature()
        }
        Reduce { state, action in
            switch action {
            case .library(.delegate(.openDetail(let item))):
                state.path.append(.libraryDetail(item))
                return .none
                
            case .library(.delegate(.openAuthor(let id))):
                state.path.append(.author(id))
                return .none
                
            case .library:
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

struct LibraryFeature: Reducer {
    struct State: Equatable, Identifiable {
        var items: [String]
        var id: TabItem { .library }
        
        init(items: [String] = Array(0...10).map{"Library:\($0)"}) {
            self.items = items
        }
    }
    
    enum Action: Equatable {
        case didTap(String)
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case openDetail(String)
            case openAuthor(Int)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTap(let item):
                if item.contains("1") {
                    return .send(.delegate(.openAuthor(.random(in: 0...10))))
                }
                return .send(.delegate(.openDetail(item)))
            case .delegate:
                return .none
            }
        }
    }
}


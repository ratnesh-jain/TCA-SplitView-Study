//
//  SearchFeature.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import Foundation

struct SearchFeature: Reducer {
    struct State: Equatable, Identifiable {
        @BindingState var searchText: String
        var searches: [String]
        var id: TabItem { .search }
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case searchSubmited
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .searchSubmited:
                state.searches.append(state.searchText)
                state.searchText = ""
                return .none
            }
        }
    }
}


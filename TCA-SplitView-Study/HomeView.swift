//
//  HomeView.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import SwiftUI
import Foundation
import ComposableArchitecture

struct HomeNavigationStackView: View {
    let store: StoreOf<HomeStackFeature>
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: {.path($0)})) {
            HomeView(store: store.scope(state: \.home, action: {.home($0)}))
        } destination: { destinationStore in
            SwitchStore(destinationStore) {
                switch $0 {
                case .homeDetail(let item):
                    Text(item)
                case .homeInspector(let item):
                    Text("Inspector \(item)")
                }
            }
        }
    }
}

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            List {
                ForEach(viewStore.items, id: \.self) { item in
                    Text(item)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            viewStore.send(.didTap(item))
                        }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: .init(initialState: .init(), reducer: HomeFeature()))
    }
}


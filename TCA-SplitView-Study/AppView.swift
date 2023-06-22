//
//  AppView.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppFeature>
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            tabView
        } else {
            splitView
        }
    }
    
    var splitView: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            NavigationSplitView {
                let selection: Binding<AppTabFeature.State.ID?> = viewStore.binding(get: {$0.selectedTab?.id}, send: {.select(id: $0 ?? .home)})
                List(selection: selection) {
                    ForEach(viewStore.tabItems, id: \.id) { item in
                        item.label
                    }
                }
            } detail: {
                IfLetStore(store.scope(state: {$0.selectedTab}, action: {.selectedTab($0)})) { tabStore in
                    AppTabView(store: tabStore)
                }
            }
        }
    }
    
    var tabView: some View {
        WithViewStore(store, observe: {$0.selectedTab?.id ?? .home}) { viewStore in
            TabView(selection: viewStore.binding(get: \.id, send: {.select(id: $0)})) {
                ForEachStore(store.scope(state: \.tabs, action: AppFeature.Action.selectedTabAction)) { tabStore in
                    AppTabView(store: tabStore)
                }
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(initialState: .init(), reducer: AppFeature()))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

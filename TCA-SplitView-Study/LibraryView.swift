//
//  LibraryView.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct LibraryNavigationStackView: View {
    let store: StoreOf<LibraryStackFeature>
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: {.path($0)})) {
            LibraryView(store: store.scope(state: \.library, action: {.library($0)}))
        } destination: { destinationStore in
            SwitchStore(destinationStore) {
                switch $0 {
                case .libraryDetail(let item):
                    Text(item)
                case .author(let id):
                    Text("Author: \(id)")
                }
            }
        }
    }
}

struct LibraryView: View {
    let store: StoreOf<LibraryFeature>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            List {
                ForEach(viewStore.items, id: \.self) { item in
                    Text(item)
                        .onTapGesture {
                            viewStore.send(.didTap(item))
                        }
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(store: .init(initialState: .init(), reducer: LibraryFeature()))
    }
}

//
//  SearchView.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct SearchView: View {
    let store: StoreOf<SearchFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            List {
                ForEach(viewStore.searches, id: \.self) { search in
                    Text(search)
                }
            }
            .searchable(text: viewStore.binding(\.$searchText))
            .onSubmit(of: .search) {
                viewStore.send(.searchSubmited)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView(store: .init(initialState: .init(searchText: "", searches: []), reducer: SearchFeature()))
        }
    }
}

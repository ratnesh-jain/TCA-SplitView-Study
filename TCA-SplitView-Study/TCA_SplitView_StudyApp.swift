//
//  TCA_SplitView_StudyApp.swift
//  TCA-SplitView-Study
//
//  Created by Ratnesh Jain on 18/06/23.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_SplitView_StudyApp: App {
    let store: StoreOf<AppFeature> = .init(initialState: .init(), reducer: AppFeature())
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}

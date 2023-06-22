# TCA-SplitView-Study
A toy project to reproduce the NavigationSplitView/NavigationStack runtime crash. 

## Crash
 <img width="1064" alt="Screenshot 2023-06-22 at 9 03 33 PM" src="https://github.com/ratnesh-jain/TCA-SplitView-Study/assets/117887125/7f07998c-447b-40e1-814f-66483b021a86">
 
 ```
 SwiftUI/NavigationColumnState.swift:520: Fatal error: 'try!' expression unexpectedly raised an error: SwiftUI.AnyNavigationPath.Error.comparisonTypeMismatch
 ```
 
 - It seems a bug in the SwiftUI.

## Reproduction Steps.
  - Open the `TCA-SplitView-Study.xcodeproject` file.
  - Change Xcode scheme to `Plain-SplitView-Study`.
  - Choose `iPadOS` as the run destination.
  - Run the app.
  - On the `iPadOS` simulator, click on the `Home` side bar item.
  - Click on the `Show Details` button in the Home view.
  - Now click on the `Library` side bar item.

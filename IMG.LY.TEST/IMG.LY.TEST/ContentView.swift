//
//  ContentView.swift
//  IMG.LY.TEST
//
//  Created by Miguel Bou Sleiman on 2/19/25.
//

import SwiftUI
import TreeScene
import Helpers

@main
struct ContentView: App {
    @StateObject var themeViewModel = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            TreeCoordinatorView()
                .environmentObject(themeViewModel)
        }
    }
}

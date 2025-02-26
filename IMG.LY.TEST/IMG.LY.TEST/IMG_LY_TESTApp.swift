import SwiftUI
import TreeScene
import Helpers

@main
struct IMG_LY_TESTApp: App {
    @StateObject var themeViewModel = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            TreeCoordinatorView()
                .environmentObject(themeViewModel)
        }
    }
}

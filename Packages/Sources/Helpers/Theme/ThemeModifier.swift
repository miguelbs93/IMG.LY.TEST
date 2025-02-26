import SwiftUI

// MARK: - ViewModeifier to Update Theme

public struct ThemedViewModifier: ViewModifier {
    @EnvironmentObject public var themeManager: ThemeManager

    public func body(content: Content) -> some View {
        content
            .background(Color.themeBackground)
            .foregroundColor(Color.themeText)
            .onAppear {
                updateNavigationBar()
            }
            .id(themeManager.isDarkMode)
    }
    
    private func updateNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color.themeBackground)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.themeText)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.themeText)]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

public extension View {
    func applyTheme() -> some View {
        self.modifier(ThemedViewModifier())
    }
}

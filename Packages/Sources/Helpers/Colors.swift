import SwiftUI

public extension Color {
    
    static var themeBackground: Color {
        isDarkMode ? .black : .init(uiColor: .secondarySystemBackground)
    }
    
    static var themeText: Color {
        isDarkMode ? .white : .black
    }
    
    static var themeRowBackground: Color {
        isDarkMode ? .init(white: 0.35): .white
    }
    
    static var loaderColor: Color {
        isDarkMode ? .white : .gray
    }
    static var primary: Color {
        .blue
    }
    
    /// Reads the theme preference from UserDefaults
    private static var isDarkMode: Bool {
        UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
}

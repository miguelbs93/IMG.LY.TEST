import SwiftUI

public class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") private var isDarkModePersistent: Bool = false
    
    @Published public var isDarkMode: Bool = false {
        didSet {
            isDarkModePersistent = isDarkMode
        }
    }
    
    public init() {
        isDarkMode = isDarkModePersistent
    }
    
    public func toggleTheme() {
        isDarkMode.toggle()
    }
}

import Foundation

extension Date {
    /// Converts a `Date` to a string using a custom date format.
    public func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

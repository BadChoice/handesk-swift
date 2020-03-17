import Foundation

extension Date {
    
    public enum Style : String {
        case iso8061 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case display = "E, MMM d HH:mm"
    }
    
    static var cachedFormatters: [String: DateFormatter] = [:]
    
    init?(iso8061:String) {
        let formatter  = Self.cachedFormatter(style: .iso8061)
        guard let date = formatter.date(from: iso8061) else {
            return nil
        }
        self.init(timeInterval:0, since:date)
    }
    
    var display:String {
        let formatter = Self.cachedFormatter(style: .display)
        return formatter.string(from: self)
    }
    
    static public func cachedFormatter(style:Style) -> DateFormatter {
        if let cached = Date.cachedFormatters["\(style)"] {
            return cached            
        }
        let formatter                = DateFormatter()
        formatter.dateFormat         = style.rawValue
        Date.cachedFormatters["\(style)"] = formatter
        return formatter
    }
}

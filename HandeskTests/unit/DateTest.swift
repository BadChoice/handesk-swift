import XCTest
@testable import Handesk

class DateTest: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func test_can_initialize_date_from_iso8061_string(){
        let date = Date(iso8061:"2020-03-17T19:20:14+0000")
        
        XCTAssertEqual("2020-03-17 19:20:14 +0000", date?.description)
    }

    func test_can_display_nice_date(){
        let date = Date(iso8061:"2020-03-17T19:20:14+0000")
        NSTimeZone.default = TimeZone(secondsFromGMT: -3600)!
        
        XCTAssertEqual("Tue, Mar 17 18:20", date!.display)
    }
    
    func test_formatters_can_be_cached(){
        let formatter = Date.cachedFormatter(style: .iso8061)
        let formatter2 = Date.cachedFormatter(style: .iso8061)
        XCTAssertTrue(formatter === formatter2)
    }
}

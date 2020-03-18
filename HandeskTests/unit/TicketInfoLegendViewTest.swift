import XCTest
@testable import Handesk

class TicketInfoLegendViewTest: XCTestCase {

    override func setUp() {}

    override func tearDown() { }

    func test_it_displays_and_priority() {
       
        let ticket    = Ticket(title: "The Ticket", priority:.high, bug:false, escalated:false)
        
        let stackView   = TicketInfoLegendView()
        
        stackView.setup(ticket)
        
        XCTAssertEqual(1, stackView.arrangedSubviews.count)
        let typeView = stackView.arrangedSubviews.first as! UILabel
        XCTAssertEqual("H", typeView.text)
        XCTAssertEqual(UIColor(named:"priority-high"), typeView.backgroundColor)
        
        
        let ticket2    = Ticket(title: "The Ticket", priority:.normal, bug:false, escalated:false)
        stackView.setup(ticket2)
        let typeView2 = stackView.arrangedSubviews.first as! UILabel
        XCTAssertEqual("N", typeView2.text)
        XCTAssertEqual(UIColor(named:"priority-normal"), typeView2.backgroundColor)
    }
    
    func test_it_displays_when_it_is_a_bug(){
        let ticket    = Ticket(title: "The Ticket", priority:.high, bug:true, escalated:false)

        let stackView = TicketInfoLegendView()

        stackView.setup(ticket)

        XCTAssertEqual(2, stackView.arrangedSubviews.count)
        let imageView = stackView.arrangedSubviews.last as! UIImageView
        XCTAssertEqual(UIImage(named:"bug"), imageView.image)
        XCTAssertEqual(UIColor.white, imageView.tintColor)
    }
    
    func test_it_displays_when_it_is_escalated(){
        let ticket    = Ticket(title: "The Ticket", priority:.high, bug:false, escalated:true)

        let stackView = TicketInfoLegendView()

        stackView.setup(ticket)

        XCTAssertEqual(2, stackView.arrangedSubviews.count)
        let imageView = stackView.arrangedSubviews.last as! UIImageView
        XCTAssertEqual(UIImage(named:"flag"), imageView.image)
        XCTAssertEqual(UIColor.white, imageView.tintColor)
    }
}

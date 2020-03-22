import XCTest
@testable import Handesk

class TicketStatusTest: XCTestCase {

    func test_status_can_have_a_color(){
        XCTAssertEqual(UIColor(named:"status-new")!, Ticket.Status.new.color)
        XCTAssertEqual(UIColor(named:"status-open")!, Ticket.Status.open.color)
        XCTAssertEqual(UIColor(named:"status-pending")!, Ticket.Status.pending.color)
        XCTAssertEqual(UIColor(named:"status-solved")!, Ticket.Status.solved.color)
        XCTAssertEqual(UIColor(named:"status-closed")!, Ticket.Status.closed.color)
        XCTAssertEqual(UIColor(named:"status-merged")!, Ticket.Status.merged.color)
        XCTAssertEqual(UIColor(named:"status-spam")!, Ticket.Status.spam.color)
    }
}

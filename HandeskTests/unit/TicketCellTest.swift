import XCTest
@testable import Handesk

class TicketCellTest: XCTestCase {

    override func setUp() {}
    override func tearDown() {}

    
    func test_cell_can_display_a_ticket() {
        
        let requester = Requester(name: "Bruce Wayne", email:"bruce@wayne.com")
        let ticket    = Ticket(title: "The Ticket", body:"Body", requester:requester, updated_at:"2020-17-03T19:20:14+0000", status:.new, priority:.high, isBug:false, isEscalated:true)
        let cell      = makeTicketCell()
        
        cell.setup(ticket)
        
        XCTAssertEqual("The Ticket",    cell.titleLabel.text)
        XCTAssertEqual("Bruce Wayne",   cell.userLabel.text)
        XCTAssertEqual("Body",          cell.bodyLabel.text)
        XCTAssertEqual("Tue 17, 20:20", cell.updatedAtLabel.text)
        XCTAssertEqual(UIColor.green,   cell.statusView.backgroundColor)
        XCTAssertEqual(3,               cell.infoStackView.arrangedSubviews.count)
        XCTAssertNotNil(cell.avatarView.image)
    }


}
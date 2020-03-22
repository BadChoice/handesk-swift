import XCTest
@testable import Handesk

class TicketHeaderCellTest: XCTestCase {

    override func setUp() {
        NSTimeZone.default = TimeZone(secondsFromGMT: -3600)!
    }
    
    func test_cell_can_display_a_ticket() {        
        let requester = Requester(name: "Bruce Wayne", email:"bruce@wayne.com")
        let ticket    = Ticket(title: "The Ticket", body:"Body", requester:requester, created_at:"2020-03-17T19:20:14+0000", status:.new, priority:.high, bug:false, escalated:true)
        let cell      = makeTicketHeaderCell()
                
        Container.shared.register(ImageDownloader.self, ImageDownloaderMock())
        
        cell.setup(ticket)
        
        XCTAssertEqual("The Ticket",                 cell.titleLabel.text)
        XCTAssertEqual("Bruce Wayne",                cell.userLabel.text)
        XCTAssertEqual("Tue, Mar 17 18:20",          cell.createdAtLabel.text)
        XCTAssertEqual(UIColor(named:"status-new")!, cell.statusView.backgroundColor)
        XCTAssertEqual(2,                            cell.infoStackView.arrangedSubviews.count)
        XCTAssertNotNil(cell.avatarView.image)
    }
}

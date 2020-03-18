import XCTest
@testable import Handesk

class TicketCellTest: XCTestCase {

    override func setUp() {
        NSTimeZone.default = TimeZone(secondsFromGMT: -3600)!
    }
    
    override func tearDown() {}

    
    func test_cell_can_display_a_ticket() {
        
        let requester = Requester(name: "Bruce Wayne", email:"bruce@wayne.com")
        let ticket    = Ticket(title: "The Ticket", body:"Body", requester:requester, updated_at:"2020-03-17T19:20:14+0000", status:.new, priority:.high, isBug:false, isEscalated:true)
        let cell      = makeTicketCell()
        
        
        let gravatar = Gravatar()
        gravatar.imageDownloader = ImageDownloaderMock()
        cell.gravatar = gravatar
        
        cell.setup(ticket)
        
        XCTAssertEqual("The Ticket",                 cell.titleLabel.text)
        XCTAssertEqual("Bruce Wayne",                cell.userLabel.text)
        XCTAssertEqual("Body",                       cell.bodyLabel.text)
        XCTAssertEqual("Tue, Mar 17 18:20",          cell.updatedAtLabel.text)
        XCTAssertEqual(UIColor(named:"status-new")!, cell.statusView.backgroundColor)
        XCTAssertEqual(2,                            cell.infoStackView.arrangedSubviews.count)
        XCTAssertNotNil(cell.avatarView.image)
    }


}

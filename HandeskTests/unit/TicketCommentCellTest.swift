import XCTest
@testable import Handesk


class TicketCommentCellTest: XCTestCase {

    override func setUp() {
        NSTimeZone.default = TimeZone(secondsFromGMT: -3600)!
    }
    
    func test_cell_can_display_a_normal_comment() {

        let requester = Requester(name: "Bruce Wayne", email: "bruce@wayne.com")
        let comment   = Comment(requester: requester, isPrivate: false, body: "This is the body", created_at: "2020-03-17T19:20:14+0000")
        let cell      = makeTicketCommentCell()
        
        Container.shared.register(ImageDownloader.self, ImageDownloaderMock())
        
        
        cell.setup(comment)

        XCTAssertEqual("Bruce Wayne",              cell.authorLabel.text)
        XCTAssertEqual("Tue, Mar 17 18:20",        cell.createdAtLabel.text)
        XCTAssertEqual("This is the body",         cell.bodyLabel.text)
        XCTAssertEqual(UIColor.clear,              cell.bodyLabel.backgroundColor)
        XCTAssertNotNil(cell.avatarView.image)
    }
    
    func test_cell_can_display_a_private_comment() {

        let requester = Requester(name: "Bruce Wayne", email: "bruce@wayne.com")
        let comment   = Comment(requester: requester, isPrivate: true, body: "This is the body", created_at: "2020-03-17T19:20:14+0000")
        let cell      = makeTicketCommentCell()
        
        Container.shared.register(ImageDownloader.self, ImageDownloaderMock())
        
        
        cell.setup(comment)

        XCTAssertEqual("Bruce Wayne",              cell.authorLabel.text)
        XCTAssertEqual("Tue, Mar 17 18:20",        cell.createdAtLabel.text)
        XCTAssertEqual("This is the body",         cell.bodyLabel.text)
        XCTAssertEqual(UIColor(named: "note"),     cell.bodyLabel.backgroundColor)
        XCTAssertNotNil(cell.avatarView.image)
    }

}

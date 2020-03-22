import XCTest
@testable import Handesk

class TicketViewControllerTest: XCTestCase {

    func test_it_displays_the_ticket_header(){
        //Arrange
        let requester   = Requester(name: "Bruce Wayne",  email:"bruce@wayne.com")
        let agent       = Agent    (name: "Dick Grayson", email:"dick@wayne.com")
        
        var ticket      = Ticket(title: "The Ticket", body:"Body", requester:requester, updated_at:"2020-03-17T19:20:14+0000", status:.new, priority:.high, isBug:false, isEscalated:true)
        
        ticket.comments = [
            Comment(requester: requester, isPrivate:false, body:"Non private comment body", updated_at:"2020-03-17T20:20:14+0000"),
            Comment(requester: agent,     isPrivate:true, body:"Private comment body", updated_at:"2020-03-17T20:50:14+0000")
        ]
        
        let vc        = TicketViewController()
        let tableView = UITableViewMock()
        
        //Act
        vc.tableView = tableView
        vc.ticket    = ticket;
        
        //Assert
        XCTAssertEqual (5, vc.tableView(vc.tableView, numberOfRowsInSection: 0))
        
        let headerCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TicketHeaderCell
        XCTAssertEqual("The Ticket",                 headerCell.titleLabel.text)
        XCTAssertEqual("Bruce Wayne",                headerCell.userLabel.text)
        XCTAssertEqual("Tue, Mar 17 18:20",          headerCell.createdAtLabel.text)
        XCTAssertEqual(UIColor(named:"status-new")!, headerCell.statusView.backgroundColor)
        XCTAssertEqual(1,                            headerCell.infoStackView.arrangedSubviews.count)
        XCTAssertNotNil(headerCell.avatarView.image)
        
        let infoCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as! TicketInfoCell
        XCTAssertEqual("--",            infoCell.teamLabel.text)
        XCTAssertEqual("--",            infoCell.assigneLabel.text)
        XCTAssertEqual("new",           infoCell.statusLabel.text)
        XCTAssertEqual("high",          infoCell.priorityLabel.text)
        
        let bodyCommentCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! TicketCommentCell
        XCTAssertEqual("Bruce Wayne",               bodyCommentCell.authorLabel.text)
        XCTAssertEqual("Tue, Mar 17 18:20",         bodyCommentCell.createdAtLabel.text)
        XCTAssertEqual("Body",                      bodyCommentCell.bodyLabel.text)
        XCTAssertEqual(UIColor.clear,               bodyCommentCell.bodyLabel.backgroundColor)
        XCTAssertNotNil(bodyCommentCell.avatarView.image)
        
        let publicCommentCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 1, section: 1)) as! TicketCommentCell
        XCTAssertEqual("Bruce Wayne",               publicCommentCell.authorLabel.text)
        XCTAssertEqual("Tue, Mar 17 19:20",         publicCommentCell.createdAtLabel.text)
        XCTAssertEqual("Non private comment body",  publicCommentCell.bodyLabel.text)
        XCTAssertEqual(UIColor.clear,               publicCommentCell.bodyLabel.backgroundColor)
        XCTAssertNotNil(bodyCommentCell.avatarView.image)
        
        let privateCommentCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 2, section: 1)) as! TicketCommentCell
        XCTAssertEqual("Dick Grayson",              privateCommentCell.authorLabel.text)
        XCTAssertEqual("Tue, Mar 17 19:50",         privateCommentCell.createdAtLabel.text)
        XCTAssertEqual("Private comment body",      privateCommentCell.bodyLabel.text)
        XCTAssertEqual(UIColor(named:"note"),       privateCommentCell.bodyLabel.backgroundColor)
        XCTAssertNotNil(bodyCommentCell.avatarView.image)
    }
}

import XCTest
@testable import Handesk

class TicketViewControllerTest: XCTestCase {

    override func setUp() {
        NSTimeZone.default = TimeZone(secondsFromGMT: -3600)!
    }
    
    func test_it_displays_the_ticket_header(){
        //Arrange
        let requester   = Requester(name: "Bruce Wayne",  email:"bruce@wayne.com")
        let agent       = Agent    (name: "Dick Grayson", email:"dick@wayne.com")
        
        var ticket      = Ticket(title: "The Ticket", body:"Body", requester:requester, created_at:"2020-03-17T17:20:14+0000", updated_at:"2020-03-17T19:20:14+0000", status:.new, priority:.high, bug:false, escalated:true)
        
        ticket.comments = [
            Comment(requester: requester, isPrivate:false, body:"Non private comment body", created_at: "2020-03-17T20:20:14+0000"),
            Comment(requester: agent,     isPrivate:true, body:"Private comment body", created_at:"2020-03-17T20:50:14+0000")
        ]
        
        let vc:TicketViewController = instantiateStoryboardController("Tickets", "show")!
        Container.shared.register(ImageDownloader.self, ImageDownloaderMock())
        
        //Act
        vc.ticket    = ticket;
        
        //Assert
        XCTAssertEqual (2, vc.tableView(vc.tableView, numberOfRowsInSection: 0))
        XCTAssertEqual (3, vc.tableView(vc.tableView, numberOfRowsInSection: 1))
        
        let headerCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TicketHeaderCell
        XCTAssertEqual("The Ticket",                 headerCell.titleLabel.text)
        XCTAssertEqual("Bruce Wayne",                headerCell.userLabel.text)
        XCTAssertEqual("Tue, Mar 17 16:20",          headerCell.createdAtLabel.text)
        XCTAssertEqual(UIColor(named:"status-new")!, headerCell.statusView.backgroundColor)
        XCTAssertEqual(2,                            headerCell.infoStackView.arrangedSubviews.count)
        XCTAssertNotNil(headerCell.avatarView.image)
        
        let infoCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as! TicketInfoCell
        XCTAssertEqual("--",            infoCell.teamLabel.text)
        XCTAssertEqual("--",            infoCell.assigneLabel.text)
        XCTAssertEqual("new",           infoCell.statusLabel.text)
        XCTAssertEqual("high",          infoCell.priorityLabel.text)
        
        let bodyCommentCell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! TicketCommentCell
        XCTAssertEqual("Bruce Wayne",               bodyCommentCell.authorLabel.text)
        XCTAssertEqual("Tue, Mar 17 16:20",         bodyCommentCell.createdAtLabel.text)
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
    
    func test_it_fetches_the_ticket_comments(){
        let ticketWithoutComments   = Ticket(id:10, title: "My first ticket")
        var ticketWithComments      = Ticket(id:10, title: "My first ticket")
        ticketWithComments.comments = [
            Comment(body: "First comment"),
            Comment(body: "Second comment"),
        ]
        
        let provider      = TicketsProviderMock([ticketWithComments])
        let tableView = UITableViewMock()
        let vc:TicketViewController = instantiateStoryboardController("Tickets", "show")!
        vc.ticket          = ticketWithoutComments
        vc.ticketsProvider = provider
        vc.tableView       = tableView
        
        XCTAssertNil(vc.ticket.comments)
        
        //Act
        vc.viewDidLoad()
        
        //Assert
        XCTAssertEqual([10], provider.ticketsFetched)
        XCTAssertEqual(1, tableView.didReloadDataCallCount)
        XCTAssertEqual(2, vc.ticket.comments?.count)
    }
}

import XCTest
@testable import Handesk


class TicketsListViewControllerTest: XCTestCase {
    
    func test_the_tickets_list_storyboard_resolves_with_right_controller(){
        //Act
        let ticketsController:TicketsListViewController = instantiateStoryboardController("Tickets")!
        
        //Assert
        XCTAssertNotNil(ticketsController)
        XCTAssertNotNil(ticketsController.tableView)
    }

    func test_we_can_list_the_tickets()
    {
        //Arrange
        let vc:TicketsListViewController     = instantiateStoryboardController("Tickets")!
                
        //Act
        vc.tickets = [Ticket(title: "My first ticket"), Ticket(title: "My second ticket"), Ticket(title: "My third ticket")]
        
        
        //Assert
        XCTAssertEqual (3, vc.tableView(vc.tableView, numberOfRowsInSection: 0))
        
        let ticketCellA = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual("My first ticket", ticketCellA.textLabel!.text)
        
        let ticketCellB = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual("My second ticket", ticketCellB.textLabel!.text)
        
        let ticketCellC = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        XCTAssertEqual("My third ticket", ticketCellC.textLabel!.text)
    }
    
    func test_cells_are_dequeued(){
        // Arrange
        let vc      = TicketsListViewController()
        let tickets = [Ticket(title: "My first ticket")]
        vc.tickets  = tickets
        
        // Act
        let tableView   = UITableViewMock()
        let ticketCellA = vc.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual("My first ticket", ticketCellA.textLabel!.text)
        
        // Assert
        XCTAssertEqual(["cell"], tableView.dequeuedIdentifiers)
    }
    
    func test_that_it_uses_custom_ticket_cells(){
        //Arrange
        let ticketsController:TicketsListViewController = instantiateStoryboardController("Tickets")!
        ticketsController.tickets = [Ticket(title: "My first ticket")]

        //Act
        let ticketCell = ticketsController.tableView(ticketsController.tableView, cellForRowAt:IndexPath(row:0, section:0))
        
        //Assert
        XCTAssertTrue(ticketCell is TicketCell)
    }
    
    func test_ticket_cell_outlets_are_connected(){
        //Arrange
        let ticketsController:TicketsListViewController = instantiateStoryboardController("Tickets")!
        ticketsController.tickets = [Ticket(title: "My first ticket")]
        
        //Act
        let ticketCell = ticketsController.tableView(ticketsController.tableView, cellForRowAt:IndexPath(row:0, section:0)) as! TicketCell
        
        //Assert
        XCTAssertNotNil(ticketCell.userLabel)
        XCTAssertNotNil(ticketCell.titleLabel)
        XCTAssertNotNil(ticketCell.bodyLabel)
        XCTAssertNotNil(ticketCell.updatedAtLabel)
        XCTAssertNotNil(ticketCell.statusView)
        XCTAssertNotNil(ticketCell.avatarView)
        XCTAssertNotNil(ticketCell.infoStackView)
    }
    
    
    func test_it_can_fetch_tickets(){
        // Arrange
        let ticketsProvider = TicketsProviderMock([
            Ticket(title: "My first ticket"),
            Ticket(title: "My second ticket"),
            Ticket(title: "My third ticket")
        ])
        
        let tableViewMock  = UITableViewMock()
        
        let vc             = TicketsListViewController()
        vc.ticketsProvider = ticketsProvider
        vc.tableView       = tableViewMock
        
        // Act
        vc.viewDidLoad()

        // Assert
        XCTAssertTrue(ticketsProvider.didFetchTheTickets)
        XCTAssertEqual(1, tableViewMock.didReloadDataCallCount)
        XCTAssertEqual(vc.tickets[0], ticketsProvider.tickets[0])
        XCTAssertEqual(vc.tickets[1], ticketsProvider.tickets[1])
        XCTAssertEqual(vc.tickets[2], ticketsProvider.tickets[2])
    }
    
    func test_table_view_is_reloaded_when_tickets_are_fetched(){        
        let tableViewMock  = UITableViewMock()
        
        let vc             = TicketsListViewController()
        vc.tableView       = tableViewMock
        XCTAssertEqual(0, tableViewMock.didReloadDataCallCount)
        
        // Act
        vc.onTicketsFetched([])

        // Assert
        XCTAssertEqual(1, tableViewMock.didReloadDataCallCount)
    }
    
    func test_can_pull_to_refresh(){
        //Arrange
        let vc:TicketsListViewController = instantiateStoryboardController("Tickets")!
        
        //Act
        vc.viewDidLoad()
        
        //Assert
        XCTAssertNotNil(vc.refreshControl)
        XCTAssertTrue  (vc.tableView.subviews.contains(vc.refreshControl))
        
        XCTAssertEqual (1, vc.refreshControl.actions(forTarget: vc, forControlEvent: .valueChanged)!.count)
        XCTAssertEqual ("onPulledToRefresh", vc.refreshControl.actions(forTarget:vc, forControlEvent:.valueChanged)?.first)
    }
    
    func test_pulling_to_refresh_updates_the_tickets(){
        class UIRefreshControlMock: UIRefreshControl {
            var didEndRefreshing = false
            override func endRefreshing() {
                didEndRefreshing = true
                super.endRefreshing()
            }
        }
        
        //Arrange
        let initialTicketsProvider = TicketsProviderMock([
            Ticket(title: "First ticket"),
            Ticket(title: "Second ticket"),
        ])
        
        let secondTicketsProvider = TicketsProviderMock([
            Ticket(title: "First ticket"),
            Ticket(title: "Second ticket"),
            Ticket(title: "Third ticket"),
        ])
        
        let tableView       = UITableViewMock()
        let refreshControl  = UIRefreshControlMock()
        
        let vc:TicketsListViewController = instantiateStoryboardController("Tickets")!
        vc.ticketsProvider  = initialTicketsProvider
        vc.tableView        = tableView
        vc.refreshControl   = refreshControl
        
        vc.viewDidLoad()
        
        XCTAssertEqual(2, vc.tickets.count)
        XCTAssertEqual(1, tableView.didReloadDataCallCount)
        
        //Act
        vc.ticketsProvider  = secondTicketsProvider
        vc.onPulledToRefresh()
        

        //Assert
        XCTAssertEqual(3, vc.tickets.count)
        XCTAssertEqual(2, tableView.didReloadDataCallCount)
        XCTAssertTrue(refreshControl.didEndRefreshing)
    }
        
}

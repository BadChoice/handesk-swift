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
        
}

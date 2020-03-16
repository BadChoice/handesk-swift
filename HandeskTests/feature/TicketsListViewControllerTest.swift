import XCTest
@testable import Handesk

class TicketsListViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
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
        class UITableViewMock : UITableView {
            var dequeuedIdentifiers:[String] = []
            override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
                dequeuedIdentifiers.append(identifier)
                return super.dequeueReusableCell(withIdentifier: identifier)
            }
        }
        
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
    
    func instantiateStoryboardController<T:UIViewController>(_ storyboard:String) -> T? {
        let storyBoard   = UIStoryboard(name: storyboard, bundle: nil)
        let controller   = storyBoard.instantiateInitialViewController() as? T
        controller?.loadView()
        return controller
    }
        
}

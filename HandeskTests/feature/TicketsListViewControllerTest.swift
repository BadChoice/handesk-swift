import XCTest
@testable import Handesk

class TicketsListViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_we_can_list_the_tickets()
    {
        //Arrange
        let vc = TicketsListViewController()
        
        let ticketA = Ticket(title: "My first ticket")
        let ticketB = Ticket(title: "My second ticket")
        let ticketC = Ticket(title: "My third ticket")
        
        let tickets =  [ticketA, ticketB, ticketC]
        
        //Act
        vc.tickets = tickets
        
        
        //Assert
        let tableView = UITableView()
        XCTAssertEqual (3, vc.tableView(tableView, numberOfRowsInSection: 0))
        
        let ticketCellA = vc.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual("My first ticket", ticketCellA.textLabel!.text)
        
        let ticketCellB = vc.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual("My second ticket", ticketCellB.textLabel!.text)
        
        let ticketCellC = vc.tableView(tableView, cellForRowAt: IndexPath(row: 2, section: 0))
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

}

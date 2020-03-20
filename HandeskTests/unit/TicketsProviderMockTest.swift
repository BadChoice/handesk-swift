import XCTest
@testable import Handesk

class TicketsProviderMockTest: XCTestCase {

    func test_it_can_fetch_tickets(){
        //Arrange
        let ticketsProvider = TicketsProviderMock([
            Ticket(title: "My first ticket"),
            Ticket(title: "My second ticket"),
            Ticket(title: "My third ticket")
        ])
        
        let expectation = XCTestExpectation(description: "Tickets fetched")
        
        XCTAssertFalse(ticketsProvider.didFetchTheTickets);
        
        //Act
        ticketsProvider.fetch {
            XCTAssertEqual(3, $0.count)
            XCTAssertEqual($0[0],   ticketsProvider.tickets[0])
            XCTAssertEqual($0[1],   ticketsProvider.tickets[1])
            XCTAssertEqual($0[2],   ticketsProvider.tickets[2])
            expectation.fulfill()
        }
        
        //Assert
        XCTAssertTrue(ticketsProvider.didFetchTheTickets)
        wait(for: [expectation], timeout: 1)
    }
}

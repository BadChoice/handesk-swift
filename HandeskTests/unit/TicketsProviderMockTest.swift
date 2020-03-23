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
    
    
    func test_it_can_fetch_a_ticket_by_its_id() {
        var ticket = Ticket(id:10, title: "My first ticket")
        ticket.comments = [
            Comment(body: "First comment"),
            Comment(body: "Second comment"),
        ]
        let anotherTicket = Ticket(id:11, title: "Another ticket")
        let provider = TicketsProviderMock([anotherTicket, ticket])

        
        let expectation = XCTestExpectation(description: "Ticket fetched")
                        
        //Act
        provider.fetchTicket(id: 10) { ticket in
            XCTAssertEqual(2, ticket.comments?.count)
            XCTAssertEqual("My first ticket", ticket.title)
            XCTAssertEqual("First comment", ticket.comments![0].body)
            XCTAssertEqual("Second comment", ticket.comments![1].body)
                    
            expectation.fulfill()
        }
        

        //Assert
        XCTAssertEqual([10], provider.ticketsFetched)
        wait(for: [expectation], timeout: 1)
    }
        
}

import Foundation
@testable import Handesk

class TicketsProviderMock : TicketsProvider {
    let tickets: [Ticket]
    var didFetchTheTickets = false
    
    init(_ tickets:[Ticket]){
        self.tickets = tickets
    }
    
    override func fetch(then:(_ tickets:[Ticket])->Void){
        didFetchTheTickets = true
        then(tickets)
    }
}


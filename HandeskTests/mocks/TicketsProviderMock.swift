import Foundation
@testable import Handesk

class TicketsProviderMock : TicketsProvider {
    let tickets: [Ticket]
    var didFetchTheTickets = false
    var ticketsFetched:[Int] = []
    
    init(_ tickets:[Ticket]){
        self.tickets = tickets
    }
    
    override func fetch(then:(_ tickets:[Ticket])->Void){
        didFetchTheTickets = true
        then(tickets)
    }
    
    override func fetchTicket(id:Int, then:(_ ticket:Ticket)->Void){
        ticketsFetched.append(id)
        then(tickets.first { $0.id == id }! )
    }
}


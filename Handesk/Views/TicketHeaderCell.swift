import UIKit

class TicketHeaderCell : TicketCell {
    @IBOutlet weak var createdAtLabel:UILabel!
    
    override func setup(_ ticket:Ticket){
        super.setup(ticket)
        createdAtLabel.text = Date(iso8061: ticket.created_at)?.display
    }
}


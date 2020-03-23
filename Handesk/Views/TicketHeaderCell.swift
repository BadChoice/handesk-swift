import UIKit

class TicketHeaderCell : TicketCell {
    @IBOutlet weak var createdAtLabel:UILabel!
    
    @discardableResult
    override func setup(_ ticket:Ticket) -> TicketCell{
        super.setup(ticket)
        createdAtLabel.text = Date(iso8061: ticket.created_at)?.display
        return self
    }
}


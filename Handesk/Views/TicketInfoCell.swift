import UIKit

class TicketInfoCell:UITableViewCell {
    @IBOutlet weak var teamLabel:UILabel!
    @IBOutlet weak var assigneLabel:UILabel!
    @IBOutlet weak var statusLabel:UILabel!
    @IBOutlet weak var priorityLabel:UILabel!
    
    @discardableResult
    func setup(_ ticket:Ticket) -> TicketInfoCell{
        teamLabel.text      = ticket.team?.name ?? "--"
        assigneLabel.text   = ticket.agent?.name ?? "--"
        statusLabel.text    = "\(ticket.status)"
        priorityLabel.text  = "\(ticket.priority)"
        return self
    }
}

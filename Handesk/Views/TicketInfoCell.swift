import UIKit

class TicketInfoCell:UITableViewCell {
    @IBOutlet weak var teamLabel:UILabel!
    @IBOutlet weak var assigneLabel:UILabel!
    @IBOutlet weak var statusLabel:UILabel!
    @IBOutlet weak var priorityLabel:UILabel!
    
    func setup(_ ticket:Ticket){
        teamLabel.text      = ticket.team?.name ?? "--"
        assigneLabel.text   = ticket.agent?.name ?? "--"
        statusLabel.text    = "\(ticket.status)"
        priorityLabel.text  = "\(ticket.priority)"
    }
}

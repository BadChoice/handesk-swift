import UIKit

class TicketCell : UITableViewCell {
    @IBOutlet weak var userLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var bodyLabel:UILabel!
    @IBOutlet weak var updatedAtLabel:UILabel!
    @IBOutlet weak var statusView:UIView!
    @IBOutlet weak var avatarView:UIImageView!
    @IBOutlet weak var infoStackView:UIStackView!
    
    func setup(_ ticket:Ticket){
        userLabel.text  = ticket.requester.name
        titleLabel.text = ticket.title
        bodyLabel.text  = ticket.body
        updatedAtLabel.text = Date(iso8061: ticket.updated_at)?.display
        statusView.backgroundColor = ticket.status.color
    }
}

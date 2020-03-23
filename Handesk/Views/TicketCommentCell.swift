import UIKit

class TicketCommentCell : UITableViewCell
{
    @IBOutlet weak var authorLabel:UILabel!
    @IBOutlet weak var createdAtLabel:UILabel!
    @IBOutlet weak var bodyLabel:UILabel!
    @IBOutlet weak var avatarView:UIImageView!
    
    func setup(_ comment:Comment){
        authorLabel.text    = comment.requester.name
        createdAtLabel.text = Date(iso8061: comment.created_at)?.display
        bodyLabel.text     = comment.body
        bodyLabel.backgroundColor = comment.isPrivate ? UIColor(named:"note") : UIColor.clear
        comment.requester.email.gravatar { [weak self] image, error in
            self?.avatarView.image = image
        }
    }
}

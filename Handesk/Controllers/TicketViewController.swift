import UIKit

class TicketViewController : UIViewController {
    var ticket:Ticket!
    lazy var ticketsProvider:TicketsProvider! = { TicketsProvider() }()
    @IBOutlet weak var tableView:UITableView!
        
    override func viewDidLoad() {
        ticketsProvider.fetchTicket(id: ticket.id) { [weak self] ticket in
            self?.ticket = ticket
            self?.onTicketFetched()
        }
    }
    
    func onTicketFetched(){
        tableView.reloadData()
    }
    
    
    //MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 2 : ticket.conversation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! TicketCommentCell
            cell.setup(ticket.conversation[indexPath.row])
            return cell
        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! TicketHeaderCell
            cell.setup(ticket)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! TicketInfoCell
        cell.setup(ticket)
        return cell
    }
}

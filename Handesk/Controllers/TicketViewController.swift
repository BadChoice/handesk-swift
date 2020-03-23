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
            return (dequeue("comment", for:indexPath) as TicketCommentCell).setup(ticket.conversation[indexPath.row])
        }
        if indexPath.row == 0 {
            return (dequeue("header", for: indexPath) as TicketHeaderCell).setup(ticket)
        }
        return (dequeue("info", for: indexPath) as TicketInfoCell).setup(ticket)
    }
    
    private func dequeue<T:UITableViewCell>(_ identifier:String, for indexPath:IndexPath) -> T{
        return self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}

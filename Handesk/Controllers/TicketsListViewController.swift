import UIKit

class TicketsListViewController : UIViewController, UITableViewDataSource {
    var tickets:[Ticket]!
    var ticketsProvider:TicketsProvider!
    
    @IBOutlet weak var tableView:UITableView!
    
    
    override func viewDidLoad() {
        fetchTickets()
    }

    func fetchTickets(){
        ticketsProvider.fetch { [weak self] in
            self?.onTicketsFetched($0)
        }
    }

    func onTicketsFetched(_ tickets:[Ticket]){
        self.tickets = tickets
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel!.text = tickets[indexPath.row].title
        return cell
    }
}

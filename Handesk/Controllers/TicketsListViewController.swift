import UIKit

class TicketsListViewController : UIViewController, UITableViewDataSource {
    var tickets:[Ticket]!
    lazy var ticketsProvider:TicketsProvider! = { TicketsProvider() }()
    
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableView:UITableView!
    
    
    override func viewDidLoad() {
        fetchTickets()
        setupPullToRefresh()
        tableView.dataSource = self
    }
    
    func setupPullToRefresh(){
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onPulledToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    func fetchTickets(){
        ticketsProvider.fetch { [weak self] in
            self?.onTicketsFetched($0)
        }
    }
    
    @objc func onPulledToRefresh(){
        fetchTickets()
    }

    func onTicketsFetched(_ tickets:[Ticket]){
        self.tickets = tickets
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    //MARK: Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel!.text = tickets[indexPath.row].title
        return cell
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else { return }
        let vc        = segue.destination as! TicketViewController
        let indexPath = tableView.indexPath(for: cell)!
        vc.ticket     = tickets[indexPath.row]
    }
}

import UIKit

class TicketViewController : UIViewController {
    var ticket:Ticket!
    @IBOutlet weak var tableView:UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        TicketHeaderCell()
    }
}

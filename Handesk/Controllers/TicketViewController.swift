import UIKit

class TicketViewController : UIViewController {
    var ticket:Ticket!
    @IBOutlet weak var tableView:UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
        }
        return tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath)
        //tableView.dequeue("header"TicketHeaderCell()
    }
}

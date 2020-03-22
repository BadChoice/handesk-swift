import UIKit

class TicketViewController : UIViewController {
    var ticket:Ticket!
    @IBOutlet weak var tableView:UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
        //tableView.dequeue("header"TicketHeaderCell()
    }
}

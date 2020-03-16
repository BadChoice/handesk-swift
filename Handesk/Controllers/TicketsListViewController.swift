import UIKit

class TicketsListViewController : UIViewController, UITableViewDataSource {
    var tickets:[Ticket]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = tickets[indexPath.row].title
        return cell
    }
}

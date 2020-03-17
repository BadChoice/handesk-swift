import Foundation
import UIKit

@testable import Handesk

func instantiateStoryboardController<T:UIViewController>(_ storyboard:String) -> T? {
    let storyBoard   = UIStoryboard(name: storyboard, bundle: nil)
    let controller   = storyBoard.instantiateInitialViewController() as? T
    controller?.loadView()
    return controller
}

func makeTicketCell() -> TicketCell {
    let vc:TicketsListViewController = instantiateStoryboardController("Tickets")!
    vc.tickets = [Ticket(title: "My first ticket")]
    return vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TicketCell
}

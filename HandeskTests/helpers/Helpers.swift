import Foundation
import UIKit

@testable import Handesk

func instantiateStoryboardController<T:UIViewController>(_ storyboard:String, _ identifier:String? = nil) -> T? {
    let storyBoard   = UIStoryboard(name: storyboard, bundle: nil)
    var controller:T?
    if let identifier = identifier  {
        controller = storyBoard.instantiateViewController(identifier: identifier) as? T
    } else{
        controller = storyBoard.instantiateInitialViewController() as? T
    }
    controller?.loadView()
    return controller
}

func makeTicketCell() -> TicketCell {
    let vc:TicketsListViewController = instantiateStoryboardController("Tickets")!
    vc.tickets = [Ticket(title: "My first ticket")]
    return vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TicketCell
}


func makeTicketHeaderCell() -> TicketHeaderCell {
    let vc:TicketViewController = instantiateStoryboardController("Tickets", "show")!
    vc.ticket = Ticket(title: "My first ticket")
    return vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TicketHeaderCell
}

func makeTicketInfoCell() -> TicketInfoCell {
    let vc:TicketViewController = instantiateStoryboardController("Tickets", "show")!
    vc.ticket = Ticket(title: "My first ticket")
    return vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as! TicketInfoCell
}

func makeTicketCommentCell() -> TicketCommentCell {
    let vc:TicketViewController = instantiateStoryboardController("Tickets", "show")!
    vc.ticket = Ticket(title: "My first ticket")
    return vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! TicketCommentCell
}


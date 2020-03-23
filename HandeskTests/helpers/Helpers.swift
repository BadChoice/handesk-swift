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

func disableSegueAnimations(_ controller:UIViewController, segueIdentifier:String){
    (controller.value(forKey: "storyboardSegueTemplates") as! [NSObject]).first {
        ($0.value(forKey: "identifier") as! String) == segueIdentifier
    }?.setValue(false, forKey: "animates")
}




func perfomCellSegue(controller:UIViewController, identifier:String, from tableView:UITableView, at indexPath:IndexPath){
    tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
    let cell = tableView.cellForRow(at: indexPath)
    controller.performSegue(withIdentifier: identifier, sender: cell)
}


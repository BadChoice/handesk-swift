import UIKit


struct Ticket {
    enum Status {
        case new, open, pending, solved, closed, merged, spam
        
        var color: UIColor { UIColor(named: "status-\(self)") ?? UIColor.white }
    }
    enum Priority{
        case low, normal, high, blocker
        
        var color: UIColor { UIColor(named: "priority-\(self)") ?? UIColor.white }
        var initial:String { "\(self)".prefix(1).uppercased() }
    }
    
    let title:String
    let body:String
    let requester:Requester
    let updated_at:String
    let status:Status
    let priority:Priority
    let isBug:Bool
    let isEscalated:Bool
}

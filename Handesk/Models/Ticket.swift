import UIKit


struct Ticket: Equatable {
        
    enum Status {
        case new, open, pending, solved, closed, merged, spam
        
        var color: UIColor { UIColor(named: "status-\(self)") ?? UIColor.white }
    }
    
    enum Priority{
        case low, normal, high, blocker
        
        var color: UIColor { UIColor(named: "priority-\(self)") ?? UIColor.white }
        var initial:String { "\(self)".prefix(1).uppercased() }
    }
    
    let id:Int
    let title:String
    let body:String
    let requester:Requester
    let created_at:String
    let updated_at:String
    let status:Status
    let priority:Priority
    let team:Team?
    let agent:Agent?
    let isBug:Bool
    let isEscalated:Bool
    var comments:[Comment]?
    
    var conversation:[Comment] {
        [bodyAsComment()] + (comments ?? [])
    }
    
    func bodyAsComment() -> Comment {
        Comment(requester: requester, isPrivate: false, body: body, created_at: created_at)
    }
    
    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        lhs.title == rhs.title
    }
}

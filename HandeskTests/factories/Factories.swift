@testable import Handesk

extension Ticket {
    
    init(title:String,
         body:String         = "Body",
         requester:Requester = Requester(name: "Bruce", email: "email@example.com"),
         updated_at:String   = "Body",
         status:Status       = .new,
         priority:Priority   = .high,
         bug:Bool            = false,
         escalated:Bool      = false) {
            self.init(title:title, body:body, requester: requester, updated_at: updated_at, status: status, priority: priority, isBug: bug, isEscalated: escalated)
        }
}

@testable import Handesk

extension Ticket {
    
    init(title:String,
         body:String         = "Body",
         requester:Requester = Requester(name: "Bruce", email: "email@example.com"),
         created_at:String   = "2020-03-17T19:20:14+0000",
         updated_at:String   = "2020-03-17T19:20:14+0000",
         status:Status       = .new,
         priority:Priority   = .high,
         team:Team?          = nil,
         agent:Agent?        = nil,
         bug:Bool            = false,
         escalated:Bool      = false) {
        self.init(title: title, body: body, requester: requester, created_at: created_at, updated_at: updated_at, status: status, priority: priority, team: team, agent: agent, isBug: bug, isEscalated: escalated)
        }
}

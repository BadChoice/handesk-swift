@testable import Handesk

extension Ticket {
    
    init(id:Int = 0,
         title:String,
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
        self.init(id:id, title: title, body: body, requester: requester, created_at: created_at, updated_at: updated_at, status: status, priority: priority, team: team, agent: agent, isBug: bug, isEscalated: escalated)
        }
}


extension Comment{
    init(requester:Requester = Requester(name: "Bruce", email: "email@example.com"),
         privateComment:Bool =  false,
         body:String = "Body",
         created_at:String = "2020-03-17T20:20:14+0000"
    ){
        self.init( requester: requester, isPrivate:privateComment, body:body, created_at:created_at
        )
    }
}

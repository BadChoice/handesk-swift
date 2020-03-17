import Foundation


struct Ticket {
    enum Status {
        case new
    }
    enum Priority{
        case high
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

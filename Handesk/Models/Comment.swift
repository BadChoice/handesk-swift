import Foundation

protocol Author{
    var name:String { get }
    var email:String { get }
}

struct Comment{
    let requester:Author
    let isPrivate:Bool
    let body:String
    let created_at:String
}

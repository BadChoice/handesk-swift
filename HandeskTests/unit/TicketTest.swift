import XCTest
@testable import Handesk

class TicketTest: XCTestCase {

    func test_can_convert_body_to_comment() {
        let requester   = Requester(name: "Bruce Wayne",  email:"bruce@wayne.com")
        let ticket      = Ticket(title: "A new ticket", body: "this is the ticket body", requester: requester, created_at: "2020-03-17T17:20:14+0000")
        
        let comment = ticket.bodyAsComment()
        
        XCTAssertEqual("Bruce Wayne",               comment.requester.name)
        XCTAssertEqual("bruce@wayne.com",           comment.requester.email)
        XCTAssertEqual("this is the ticket body",   comment.body)
        XCTAssertEqual("2020-03-17T17:20:14+0000",  comment.created_at)
        XCTAssertFalse(comment.isPrivate)
    }
    
    func test_conversation_return_the_body() {
        let requester   = Requester(name: "Bruce Wayne",  email:"bruce@wayne.com")
        let ticket      = Ticket(title: "A new ticket", body: "this is the ticket body", requester: requester, created_at: "2020-03-17T17:20:14+0000")
        
        XCTAssertEqual(1, ticket.conversation.count)
        let comment = ticket.conversation.first!
        
        XCTAssertEqual("Bruce Wayne",               comment.requester.name)
        XCTAssertEqual("bruce@wayne.com",           comment.requester.email)
        XCTAssertEqual("this is the ticket body",   comment.body)
        XCTAssertEqual("2020-03-17T17:20:14+0000",  comment.created_at)
        XCTAssertFalse(comment.isPrivate)
    }
    
    func test_conversation_return_the_comments() {
        let requester   = Requester(name: "Bruce Wayne",  email:"bruce@wayne.com")
        let agent       = Agent(name: "Dick Grayson", email: "dick@wayne.com")
        var ticket      = Ticket(title: "A new ticket", body: "this is the ticket body", requester: requester, created_at: "2020-03-17T17:20:14+0000")
        ticket.comments = [
           Comment(requester: requester, isPrivate:false, body:"Non private comment body", created_at: "2020-03-17T20:20:14+0000"),
           Comment(requester: agent,     isPrivate:true, body:"Private comment body",      created_at:"2020-03-17T20:50:14+0000")
       ]
        
        XCTAssertEqual(3, ticket.conversation.count)
        let comment = ticket.conversation.last!
        
        XCTAssertEqual("Dick Grayson",              comment.requester.name)
        XCTAssertEqual("dick@wayne.com",            comment.requester.email)
        XCTAssertEqual("Private comment body",      comment.body)
        XCTAssertEqual("2020-03-17T20:50:14+0000",  comment.created_at)
        XCTAssertTrue(comment.isPrivate)
    }


}

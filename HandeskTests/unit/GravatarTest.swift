import XCTest
@testable import Handesk

class GravatarTest: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func test_it_can_safely_parse_the_email(){
        let safeEmail = Gravatar.safeEmail("MyEmailAddress@example.com ")
        XCTAssertEqual("myemailaddress@example.com", safeEmail)
    }
    
    func test_it_can_generate_the_hash(){
        let hash = Gravatar.hash(safeEmail: "myemailaddress@example.com")
        XCTAssertEqual("0bc83cb571cd1c50ba6f3e8a78ef1346", hash)
    }
    
    func test_it_can_generate_gravatar_url(){
        let url = Gravatar("MyEmailAddress@example.com ").url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346", url)
    }
    
    func test_can_add_size_parameter(){
        let url = Gravatar("MyEmailAddress@example.com ").size(200).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?s=200", url)
    }
    
    func test_can_add_default_parameter(){
        let url = Gravatar("MyEmailAddress@example.com ").withDefault(.mp).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?d=mp", url)
    }
    
    func test_can_add_default_parameter_url(){
        let url = Gravatar("MyEmailAddress@example.com ").withDefault("http://url.com").url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?d=http://url.com", url)
    }
    
    func test_can_add_rating_parameter(){
        let url = Gravatar("MyEmailAddress@example.com ").rating(.r).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?r=r", url)
    }
    
    func test_can_combine_parameters(){
        let url = Gravatar("MyEmailAddress@example.com ").size(200).withDefault(.mp).rating(.r).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?s=200&d=mp&r=r", url)
    }
}

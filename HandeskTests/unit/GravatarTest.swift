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
        let url = Gravatar().email("MyEmailAddress@example.com ").url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346", url)
    }
    
    func test_can_add_size_parameter(){
        let url = Gravatar().email("MyEmailAddress@example.com ").size(200).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?s=200", url)
    }
    
    func test_can_add_default_parameter(){
        let url = Gravatar().email("MyEmailAddress@example.com ").withDefault(.mp).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?d=mp", url)
    }
    
    func test_can_add_default_parameter_url(){
        let url = Gravatar().email("MyEmailAddress@example.com ").withDefault("http://url.com").url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?d=http://url.com", url)
    }
    
    func test_can_add_rating_parameter(){
        let url = Gravatar().email("MyEmailAddress@example.com ").rating(.r).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?r=r", url)
    }
    
    func test_can_combine_parameters(){
        let url = Gravatar().email("MyEmailAddress@example.com ").size(200).withDefault(.mp).rating(.r).url()
        XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346?s=200&d=mp&r=r", url)
    }
    
    func test_it_can_download_the_gravatar(){
        let expectation = XCTestExpectation(description: "Image download")
        
        let imageDownloader      = ImageDownloaderMock()
        Container.shared.register(ImageDownloader.self, imageDownloader)
        let gravatar             = Gravatar().email("MyEmailAddress@example.com ")
        
        gravatar.download { image, error in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346", imageDownloader.calledUrls.first)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_it_download_the_gravatar_can_fail(){
        let expectation = XCTestExpectation(description: "Image download")
        
        let imageDownloader      = ImageDownloaderMock(shouldFailWith:"Image can't be downloaded" )
        Container.shared.register(ImageDownloader.self, imageDownloader)
        let gravatar             = Gravatar().email("MyEmailAddress@example.com ")
        
        gravatar.download { image, error in
            XCTAssertNil(image)
            XCTAssertEqual("Image can't be downloaded", error)
            XCTAssertEqual("https://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346", imageDownloader.calledUrls.first)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
    }
}

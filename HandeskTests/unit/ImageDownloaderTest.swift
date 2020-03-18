import XCTest
@testable import Handesk

class ImageDownloaderTest: XCTestCase {

    override func setUp() { }

    override func tearDown() {}

    func test_it_can_download_an_image(){
    
        let expectation = XCTestExpectation(description: "Image downloaded")
        let url = "https://raw.githubusercontent.com/BadChoice/handesk/dev/public/images/default-avatar.png"
            
        ImageDownloader().download(url){ image, error in
            XCTAssertNotNil(image)
            XCTAssertEqual(264, image!.size.width)
            XCTAssertEqual(267, image!.size.height)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }

}

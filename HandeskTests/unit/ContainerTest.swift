import XCTest
@testable import Handesk

class ContainerTest: XCTestCase {

    func test_it_can_resolve_a_class_from_container(){
        let resolved  = Container.shared.resolve(ImageDownloader.self)
        let resolved2 = Container.shared.resolve(Gravatar.self)
        
        XCTAssertTrue(resolved != nil)
        XCTAssertTrue(resolved2 != nil)
    }
    
    func test_it_can_register_a_resolver(){
        Container.shared.register(ImageDownloader.self, ImageDownloaderMock.self)
        
        let resolved = Container.shared.resolve(ImageDownloader.self)
        
        XCTAssertTrue(resolved is ImageDownloaderMock)
    }
    
    func test_it_can_register_a_resolver_instance(){
        let mock = Container.shared.register(ImageDownloader.self, ImageDownloaderMock.self())
        
        let resolved = Container.shared.resolve(ImageDownloader.self)
        
        XCTAssertTrue(resolved === mock)
    }
    
}


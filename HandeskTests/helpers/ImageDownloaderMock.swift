import UIKit
@testable import Handesk

class ImageDownloaderMock : ImageDownloader{
    var calledUrls:[String] = []    
    let shouldFailWith:String?
    
    required convenience init() {
        self.init(shouldFailWith: nil)
    }
    
    init(shouldFailWith:String? = nil) {
        self.shouldFailWith = shouldFailWith
    }
        
    override func download(_ url:String, then:@escaping(_ image:UIImage?, _ error:String?)->Void){
        calledUrls.append(url)
        if let error = shouldFailWith {
            return then(nil, error)
        }
        then(UIImage(), nil)
    }
}

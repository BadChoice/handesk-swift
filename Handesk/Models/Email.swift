import UIKit

typealias Email = String

extension Email {
    func gravatar(_ gravatar:Gravatar = .init(), then:@escaping(_ image:UIImage?, _ error:String?)->Void) {
        gravatar.email(self).download(then:then)
    }
}

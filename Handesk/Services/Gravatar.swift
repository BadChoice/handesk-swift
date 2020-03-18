import Foundation
import CryptoKit

class Gravatar {
    
    enum Default : String{
        case notFound = "404", mp, identicon, monsterid, wavatar, retro, robohash, blank
    }
    
    enum Rating {
        case g, pg, r, x
    }
    
    let email:String
    var extraParameters:[String] = []
    
    init(_ email:String){
        self.email = Self.safeEmail(email)
    }
    
    func url() -> String {
        let hash  = Self.hash(safeEmail: email)
        let query = buildQueryParameters()
        return "https://www.gravatar.com/avatar/\(hash)\(query)"
    }
    
    private func buildQueryParameters() -> String {
        guard extraParameters.count > 0 else { return "" }
        return "?" + extraParameters.joined(separator: "&")
    }
    
    // MARK: Parameters
    func size(_ size:Int) -> Gravatar {
        extraParameters.append("s=\(size)")
        return self
    }
        
    func withDefault(_ url:String) -> Gravatar{
        extraParameters.append("d=\(url)")
        return self
    }
    
    func withDefault(_ theDefault:Default) -> Gravatar{
        extraParameters.append("d=\(theDefault.rawValue)")
        return self
    }
    
    func rating(_ rating:Rating) -> Gravatar{
        extraParameters.append("r=\(rating)")
        return self
    }
    
    // MARK: STATIC
    static func safeEmail(_ email:String) -> String{
        email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func hash(safeEmail:String)->String {
        md5(safeEmail)
    }
    
    static func md5(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

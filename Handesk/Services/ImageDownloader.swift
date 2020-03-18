import UIKit

class ImageDownloader{
    
    func download(_ url:String, then:@escaping(_ image:UIImage?, _ error:String?)->Void){
        guard let downloadUrl = URL(string: url) else {
            return then(nil, "Invalid URL")
        }
        
        URLSession.shared.dataTask(with: downloadUrl) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data     = data, error == nil,
                let image    = UIImage(data: data)
                else {
                    return on_ui { then(nil, "Something went wrong") }
                }
            on_ui { then(image, nil) }
        }.resume()
    }
}

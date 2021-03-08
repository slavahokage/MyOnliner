import Foundation

class NetworkService {
    
    static var session = URLSession.shared
 
    static func getData(url: URL, callback: @escaping (Data) -> Void) {
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error in
            callback(data!)
        })

        task.resume()
        
    }
}

//b6430e3b7d34547084b0acc97fe5b8a5

import Foundation
class NetworkService{
    func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping (Page?, RequestError?) -> Void){
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: {data, response, err in
            guard err == nil else{
                DispatchQueue.main.async {
                    completionHandler(nil, .clientError)
                }
                
                return
            }
            
            guard let httpRes = response as? HTTPURLResponse, (200...299).contains(httpRes.statusCode) else{
                DispatchQueue.main.async {
                    completionHandler(nil, .serverError)
                }
                
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, .noData)
                }
                
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(Page.self, from: data) else{
                DispatchQueue.main.async {
                    completionHandler(nil, .dataEncodingError)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(decoded, nil)
            }
        })
        
        dataTask.resume()
    }
}

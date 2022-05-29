import Foundation
import Network

class NetworkService: NetworkServiceProtocol{
    func hasConnection(completionHandler: @escaping (Bool) -> Void) -> Void{
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void){
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: {data, response, err in
            guard err == nil else{
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                
                return
            }
            
            guard let httpRes = response as? HTTPURLResponse, (200...299).contains(httpRes.statusCode) else{
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noData))
                }
                
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else{
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataEncodingError))
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(decoded))
            }
        })
        
        dataTask.resume()
    }
}

protocol NetworkServiceProtocol{
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void)
}

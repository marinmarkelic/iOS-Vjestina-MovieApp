import UIKit
import MovieAppData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var router: AppRouter!
    var nc: UINavigationController!
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        nc = UINavigationController()
        router = AppRouter(navigationController: nc)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        router.setStartScreen(in: window)
        
//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=b6430e3b7d34547084b0acc97fe5b8a5") else { return false }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        NetworkService().executeUrlRequest(request){ (result: Result<Page, RequestError>) in
//
//            switch result {
//            case .success(let value):
//                print(value)
//            case .failure(let error):
//                RequestErrorHandle(error)
//            }
//
//
//        }
        
        return true
    }
}


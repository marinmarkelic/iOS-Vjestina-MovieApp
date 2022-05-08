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
                
        return true
    }
}


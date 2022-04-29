import UIKit

class AppRouter: AppRouterProtocol{
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?){
        let vc = MovieListViewController()
        
        navigationController.pushViewController(vc, animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

protocol AppRouterProtocol{
    func setStartScreen(in window: UIWindow?)
}

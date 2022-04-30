import UIKit
class AppRouter: AppRouterProtocol{
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        
        setupNavigationController()
    }
    
    func setStartScreen(in window: UIWindow?){
        let vc = MovieListViewController()
        
        navigationController.pushViewController(vc, animated: false)
        navigationController.pushViewController(MovieTabBarController(), animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupNavigationController(){
        navigationController?.navigationBar.backgroundColor = .lightGray
        
//        navigationController.pushViewController(MovieTabBarController(), animated: false)
    }
}

protocol AppRouterProtocol{
    func setStartScreen(in window: UIWindow?)
}

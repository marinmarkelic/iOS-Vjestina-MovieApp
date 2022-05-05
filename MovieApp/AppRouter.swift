import UIKit
class AppRouter: AppRouterProtocol{
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        
        setupNavigationController()
    }
    
    func setStartScreen(in window: UIWindow?){
//        let vc = MovieListViewController()
        let movieTabBarController = MovieTabBarController()
        

        navigationController.pushViewController(movieTabBarController, animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupNavigationController(){
        navigationController?.navigationBar.backgroundColor = .lightGray
    }
    
    func pushMovieDetails(){
        let movieDetailsViewController = MovieDetailsViewController()
        navigationController.pushViewController(movieDetailsViewController, animated: false)
    }
    
    func removeMovieDetails(){
        navigationController.popViewController(animated: false)
    }
}

protocol AppRouterProtocol{
    func setStartScreen(in window: UIWindow?)
}

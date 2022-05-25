import UIKit
class AppRouter: AppRouterProtocol, MovieSelectedDelegate{
    private let navigationController: UINavigationController!
    private var dataLoader: DataLoader!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
                
        setupNavigationController()
    }
    
    func setStartScreen(in window: UIWindow?){
        
        
        let movieTabBarController = MovieTabBarController(movieSelectedDelegate: self)

        navigationController.pushViewController(movieTabBarController, animated: false)
                
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupNavigationController(){
        navigationController?.navigationBar.backgroundColor = UIColor(red: 11.0/256.0, green: 37.0/256.0, blue: 63.0/256.0, alpha: 1.0)
    }
    
    func pushMovieDetails(movieId: Int, favourite: Bool){
        let movieDetailsViewController = MovieDetailsViewController(movieId: movieId, favourite: favourite)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func movieSelected(movieId: Int, favourite: Bool) {
        pushMovieDetails(movieId: movieId, favourite: favourite)
    }
    
}

protocol AppRouterProtocol{
    func setStartScreen(in window: UIWindow?)
}

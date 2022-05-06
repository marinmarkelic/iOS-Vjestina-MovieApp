import UIKit
class AppRouter: AppRouterProtocol, TopicCollectionViewDelegate{
    private let navigationController: UINavigationController!
    private var topicCollectionViewCellDelegate: TopicCollectionViewDelegate!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        
        setupNavigationController()
    }
    
    func setStartScreen(in window: UIWindow?){
//        let vc = MovieListViewController()
        let movieTabBarController = MovieTabBarController(topicCollectionViewCellDelegate: self)
        
        
//        movieTabBarController.movieTabBardelegate = self
        

        navigationController.pushViewController(movieTabBarController, animated: false)
                
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupNavigationController(){
        navigationController?.navigationBar.backgroundColor = .lightGray
    }
    
    func pushMovieDetails(movieId: Int){
        let movieDetailsViewController = MovieDetailsViewController(movieId: movieId)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func movieSelected(movieId: Int) {
        pushMovieDetails(movieId: movieId)
    }
    
}

protocol AppRouterProtocol{
    func setStartScreen(in window: UIWindow?)
}

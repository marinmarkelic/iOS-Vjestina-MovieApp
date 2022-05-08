import UIKit
class AppRouter: AppRouterProtocol, TopicCollectionViewDelegate{
    private let navigationController: UINavigationController!
    private var topicCollectionViewCellDelegate: TopicCollectionViewDelegate!
    private var dataLoader: DataLoader!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        
        dataLoader = DataLoader()
        
        setupNavigationController()
    }
    
    func setStartScreen(in window: UIWindow?){
        
        
        let movieTabBarController = MovieTabBarController(topicCollectionViewCellDelegate: self, dataLoader: dataLoader)

        navigationController.pushViewController(movieTabBarController, animated: false)
                
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupNavigationController(){
        navigationController?.navigationBar.backgroundColor = UIColor(red: 11.0/256.0, green: 37.0/256.0, blue: 63.0/256.0, alpha: 1.0)
    }
    
    func pushMovieDetails(movieId: Int){
        let movieDetailsViewController = MovieDetailsViewController(movieId: movieId, dataLoader: dataLoader)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func movieSelected(movieId: Int) {
        pushMovieDetails(movieId: movieId)
    }
    
}

protocol AppRouterProtocol{
    func setStartScreen(in window: UIWindow?)
}

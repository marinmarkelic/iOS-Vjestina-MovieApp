import UIKit

class MovieTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    var movieSelectedDelegate: MovieSelectedDelegate!
        
    var movieListViewController: MovieListViewController!
    var favouritesController: FavouritesController!
        
    init(movieSelectedDelegate: MovieSelectedDelegate) {
        self.movieSelectedDelegate = movieSelectedDelegate
        
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = self
                
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 11.0/256.0, green: 37.0/256.0, blue: 63.0/256.0, alpha: 1.0)
        
        tabBar.backgroundColor = .white
        
        movieListViewController = MovieListViewController(movieSelectedDelegate: movieSelectedDelegate)
        favouritesController = FavouritesController(movieSelectedDelegate: movieSelectedDelegate)
        
        movieListViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
        favouritesController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), selectedImage: nil)
        
        viewControllers = [movieListViewController, favouritesController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let vc = viewController as? MovieListViewController {
            print("click")
            vc.reloadData()
        } else if let vc = viewController as? FavouritesController {
            print("click")
            vc.reloadData()
        }
    }
    
    func buildViews(){
            }
    
    func addConstraints(){
        
    }
}

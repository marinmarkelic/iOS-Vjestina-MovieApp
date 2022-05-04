import UIKit

class MovieTabBarController: UITabBarController{
    
    
    var movieListViewController: MovieListViewController!
    var favouritesController: FavouritesController!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListViewController = MovieListViewController()
        favouritesController = FavouritesController()
        viewControllers = [movieListViewController, favouritesController]
    }
    
    func buildViews(){
            }
    
    func addConstraints(){
        
    }
}

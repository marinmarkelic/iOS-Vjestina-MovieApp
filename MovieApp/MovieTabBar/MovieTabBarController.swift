import UIKit

class MovieTabBarController: UITabBarController{
    
    var topicCollectionViewCellDelegate: TopicCollectionViewDelegate!
        
    var movieListViewController: MovieListViewController!
    var favouritesController: FavouritesController!
        
    init(topicCollectionViewCellDelegate: TopicCollectionViewDelegate) {
        self.topicCollectionViewCellDelegate = topicCollectionViewCellDelegate
        
        super.init(nibName: nil, bundle: nil)
                
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
        
        movieListViewController = MovieListViewController(topicCollectionViewCellDelegate: topicCollectionViewCellDelegate)
        favouritesController = FavouritesController()
        
        movieListViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
        favouritesController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), selectedImage: nil)
        
        viewControllers = [movieListViewController, favouritesController]
    }
    
    func buildViews(){
            }
    
    func addConstraints(){
        
    }
}

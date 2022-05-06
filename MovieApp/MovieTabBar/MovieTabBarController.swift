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
        
        movieListViewController = MovieListViewController(topicCollectionViewCellDelegate: topicCollectionViewCellDelegate)
        favouritesController = FavouritesController()
        viewControllers = [movieListViewController, favouritesController]
    }
    
    func buildViews(){
            }
    
    func addConstraints(){
        
    }
}

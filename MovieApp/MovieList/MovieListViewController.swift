import UIKit
import SnapKit

class MovieListViewController: UIViewController{
    
    var topicCollectionViewCellDelegate: TopicCollectionViewDelegate!

    var dataLoader: DataLoaderProtocol!
    
    var mainView: UIView!
    var searchBar: SearchBarView!
    
    var controllerContainer: UIView!
    var movieListAllViewController: MovieListAllViewController!
    var movieListSearchingViewController: MovieListSearchingViewController!
    
    
    init(topicCollectionViewCellDelegate: TopicCollectionViewDelegate, dataLoader: DataLoaderProtocol) {
        self.topicCollectionViewCellDelegate = topicCollectionViewCellDelegate
        self.dataLoader = dataLoader
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        
        buildViewControllers()
        buildViews()
        addConstraints()
        loadData()
    }
    
    func loadData(){
        dataLoader.loadData(completionHandler: {
            self.movieListAllViewController.dataLoaded()
        })
    }
    
    
    
    func buildViewControllers(){
        movieListAllViewController = MovieListAllViewController(dataLoader: dataLoader, topicCollectionViewCellDelegate: topicCollectionViewCellDelegate)
        movieListSearchingViewController = MovieListSearchingViewController()
        
        movieListSearchingViewController.view.isHidden = true
        
        addChild(movieListAllViewController)
        addChild(movieListSearchingViewController)
        
    }
    
    func buildViews(){
        mainView = UIView()
        searchBar = SearchBarView()
        searchBar.delegate = self
        searchBar.inputDelegate = movieListSearchingViewController
        
        mainView.backgroundColor = .white
        controllerContainer = UIView()
        
        view.addSubview(mainView)
        mainView.addSubview(searchBar)
        mainView.addSubview(controllerContainer)
        controllerContainer.addSubview(movieListAllViewController.view)
        controllerContainer.addSubview(movieListSearchingViewController.view)
    }
    
    func addConstraints(){
        
        mainView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchBar.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
        }
        
        controllerContainer.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieListAllViewController.view.snp.makeConstraints{
            $0.edges.equalTo(controllerContainer)
        }
        
        movieListSearchingViewController.view.snp.makeConstraints{
            $0.edges.equalTo(controllerContainer)
        }
    }    
}

extension MovieListViewController: SearchBarDelegate{
    func replaceViewControllers(){
        if(movieListAllViewController.view.isHidden){
            movieListAllViewController.view.isHidden = false
            movieListSearchingViewController.view.isHidden = true
        }
        else{
            movieListAllViewController.view.isHidden = true
            movieListSearchingViewController.view.isHidden = false
        }
    }
}

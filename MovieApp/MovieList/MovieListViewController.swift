import UIKit
import SnapKit

class MovieListViewController: UIViewController{
    
//    var scrollView: UIScrollView!
//    var contentView: UIView!
    var mainView: UIView!
    var searchBar: SearchBarView!
    
    var controllerContainer: UIView!
    var movieListAllViewController: MovieListAllViewController!
    var movieListSearchingViewController: MovieListSearchingViewController!
    
    
    init() {
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
    }
    
    func buildViewControllers(){
        movieListAllViewController = MovieListAllViewController()
        movieListSearchingViewController = MovieListSearchingViewController()
        
        movieListSearchingViewController.view.isHidden = true
        
        addChild(movieListAllViewController)
        addChild(movieListSearchingViewController)
        
    }
    
    func buildViews(){
//        scrollView = UIScrollView()
//        contentView = UIView()
        mainView = UIView()
        searchBar = SearchBarView()
        searchBar.delegate = self
        
        mainView.backgroundColor = .white
        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(searchBarView)
        
        controllerContainer = UIView()
        
        view.addSubview(mainView)
        mainView.addSubview(searchBar)
        mainView.addSubview(controllerContainer)
        controllerContainer.addSubview(movieListAllViewController.view)
        controllerContainer.addSubview(movieListSearchingViewController.view)
    }
    
    func addConstraints(){
//        scrollView.snp.makeConstraints{
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//        contentView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//            $0.width.equalTo(view)
//        }
        
        mainView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchBar.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
        }
        
        controllerContainer.snp.makeConstraints{
            controllerContainer.backgroundColor = .yellow
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieListAllViewController.mainView.snp.makeConstraints{
            $0.edges.equalTo(controllerContainer)
        }
        
        movieListSearchingViewController.mainView.snp.makeConstraints{
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

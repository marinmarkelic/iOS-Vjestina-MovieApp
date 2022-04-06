import UIKit
import SnapKit

class MovieListViewController: UIViewController{
    
//    var scrollView: UIScrollView!
//    var contentView: UIView!
    var mainView: UIView!
    var searchBar: SearchBarView!
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
    }
    
    func buildViews(){
//        scrollView = UIScrollView()
//        contentView = UIView()
        mainView = UIView()
        searchBar = SearchBarView()
        
        mainView.backgroundColor = .white
        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(searchBarView)
        view.addSubview(mainView)
        mainView.addSubview(searchBar)
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

    }
}

import UIKit
import SnapKit

class MovieListViewController: UIViewController{
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var searchBarView: SearchBarView!
    
    
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
        scrollView = UIScrollView()
        contentView = UIView()
        searchBarView = SearchBarView()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchBarView)
    }
    
    func addConstraints(){
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        searchBarView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

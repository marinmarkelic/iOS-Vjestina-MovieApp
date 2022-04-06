import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var mainInfo: MainInfoView!
    var overview: OverviewView!
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
    }
    
    private func buildViews(){
        view.backgroundColor = .white
        
        scrollView = UIScrollView()
        contentView = UIView()
        
        
        mainInfo = MainInfoView()
        overview = OverviewView()
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(mainInfo)
        contentView.addSubview(overview)
        
    }
    
    private func addConstraints(){
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainInfo.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide).dividedBy(2)
        }
        
        overview.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mainInfo.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide).dividedBy(2)
        }
    }
}

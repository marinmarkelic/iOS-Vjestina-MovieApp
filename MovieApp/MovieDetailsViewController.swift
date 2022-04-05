import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {

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
        
        mainInfo = MainInfoView()
        overview = OverviewView()

        view.addSubview(mainInfo)
        view.addSubview(overview)
    }
    
    private func addConstraints(){
        mainInfo.snp.makeConstraints {
            $0.leading.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view)
            $0.height.equalTo(view.safeAreaLayoutGuide).dividedBy(2)

        }

        overview.snp.makeConstraints{
            $0.top.equalTo(mainInfo.snp.bottom)
            $0.width.equalTo(view)
            $0.height.equalTo(view.safeAreaLayoutGuide).dividedBy(2)
        }
    }
}

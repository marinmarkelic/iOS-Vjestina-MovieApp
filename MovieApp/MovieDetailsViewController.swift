import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {

    var mainInfo: MainInfoView
    var overview: OverviewView
    
    init(){
        mainInfo = MainInfoView()
        overview = OverviewView()
        
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
        self.view.backgroundColor = .white

        self.view.addSubview(mainInfo)
        self.view.addSubview(overview)
    }
    
    private func addConstraints(){
        mainInfo.snp.makeConstraints {
            $0.leading.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(self.view)
            $0.height.equalTo(self.view.safeAreaLayoutGuide).dividedBy(2)

        }

        overview.snp.makeConstraints{
            $0.top.equalTo(mainInfo.snp.bottom)
            $0.width.equalTo(self.view)
            $0.height.equalTo(self.view.safeAreaLayoutGuide).dividedBy(2)
        }
    }
}

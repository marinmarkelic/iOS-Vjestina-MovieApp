import UIKit
import SnapKit

class FavouritesController: UIViewController{
    
    var mainView: UIView!

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
        mainView = UIView()
        mainView.backgroundColor = .white
        
        view.addSubview(mainView)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets)
        }
    }
}

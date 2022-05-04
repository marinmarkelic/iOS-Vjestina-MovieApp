import UIKit
import SnapKit

class FavouritesController: UIViewController{

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
    }
    
    func buildViews(){
        view.backgroundColor = .cyan
    }
}

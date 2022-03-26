import UIKit
import SnapKit

class testController: UIViewController{
    
    let p: PersonView
    
    init(){
        self.p = PersonView(name: "name", role: "role")
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        self.view.addSubview(p)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints(){
        p.snp.makeConstraints{
            $0.top.equalTo(self.view).offset(50)
            $0.height.equalTo(40)
            $0.width.equalTo(self.view)
        }
    }
}

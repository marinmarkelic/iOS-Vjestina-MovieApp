import UIKit
import SnapKit

class testController: UIViewController{
    
    let p: PersonView
    let o: OverviewView
    
    init(){
        p = PersonView(name: "name", role: "role")
        o = OverviewView()
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        self.view.addSubview(p)
        self.view.addSubview(o)
        
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
        
        o.snp.makeConstraints{
            $0.width.equalTo(self.view)
            $0.height.equalTo(self.view).dividedBy(2)
            $0.top.equalTo(self.view.snp.top).offset(300)
        }
    }
}

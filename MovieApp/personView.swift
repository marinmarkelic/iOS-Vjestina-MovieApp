import UIKit
import SnapKit

class PersonView: UIView{
    
    let name: UILabel
    let role: UILabel
    
    init(name: String, role: String) {
        
        self.name = UILabel()
        self.name.text = name
        self.role = UILabel()
        self.role.text = role
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        name.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        role.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(name)
        self.addSubview(role)
    }
    
    func addConstraints(){
//        name.backgroundColor = .red
//        role.backgroundColor = .brown
        
        name.snp.makeConstraints{
            $0.width.equalTo(self)
            $0.height.equalTo(self).dividedBy(3)
        }
        role.snp.makeConstraints{
            $0.top.equalTo(name.snp.bottom).offset(3)
            $0.width.equalTo(self)
            $0.height.equalTo(self).dividedBy(3)
        }
    }
}

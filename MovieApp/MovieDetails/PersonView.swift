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
//        name.numberOfLines = 0
        name.adjustsFontSizeToFitWidth = true

        role.font = UIFont.systemFont(ofSize: 14)
//        role.numberOfLines = 0
        role.adjustsFontSizeToFitWidth = true
        
        self.addSubview(name)
        self.addSubview(role)
    }
    
    func addConstraints(){
        name.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
        }
        role.snp.makeConstraints{
            $0.top.equalTo(name.snp.bottom).offset(3)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}

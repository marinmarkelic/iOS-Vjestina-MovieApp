import UIKit
import SnapKit
import MovieAppData

class ButtonCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        button = UIButton()
    }
    
    func set(title: String){
        
//        switch filter {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
        
        button.setTitle(title, for: .normal)
    }
    
    func addConstraints(){
        button.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

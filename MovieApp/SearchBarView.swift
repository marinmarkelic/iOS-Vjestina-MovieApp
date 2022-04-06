import UIKit
import SnapKit

class SearchBarView: UIView{
    var grayView: UIView!
    var searchImage: UIImageView!
    var searchText: UILabel!
    var deleteButton: UIButton!
    var cancelButton: UIButton!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        grayView = UIView()
        searchImage = UIImageView()
        searchText = UILabel()
        deleteButton = UIButton()
        cancelButton = UIButton()
        
        grayView.backgroundColor = .gray
        
        searchText.text = "Search"
        
        addSubview(grayView)
        grayView.addSubview(searchImage)
        grayView.addSubview(searchText)
        grayView.addSubview(deleteButton)
        addSubview(cancelButton)
    }
    
    func addConstraints(){
        grayView.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        searchImage.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
        }
        
        searchText.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(searchImage.snp.trailing)
        }
        
        deleteButton.snp.makeConstraints{
            $0.leading.equalTo(searchText.snp.trailing)
            $0.top.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints{
            $0.leading.equalTo(grayView.snp.trailing)
            $0.top.equalToSuperview()
        }
    }
}

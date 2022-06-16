import UIKit
import SnapKit

class testController: UIViewController{
    
    var mainView: UIView!
    
    var search: SearchBarView!
    
//    var grayView: UIView!
//    var searchImage: UIImageView!
//    var searchText: UITextField!
//    var deleteButton: UIButton!
//    var cancelButton: UIButton!
    
    init(){
    super.init(nibName: nil, bundle: nil)
        
    buildViews()
    addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIView()
        mainView.backgroundColor = .white
        search = SearchBarView()
        
        view.addSubview(mainView)
        mainView.addSubview(search)
        
//        grayView = UIView()
//        searchImage = UIImageView()
//        searchText = UITextField()
//        deleteButton = UIButton()
//        cancelButton = UIButton()
//
//        searchImage.image = UIImage(named: "magnifyingGlass.jpeg")
//
//        grayView.backgroundColor = .lightGray
//        grayView.layer.cornerRadius = 10
//
//        searchText.placeholder = "Search"
//
//
//        mainView.addSubview(grayView)
//
//        grayView.addSubview(searchImage)
//        grayView.addSubview(searchText)
//        grayView.addSubview(deleteButton)
//
//        mainView.addSubview(cancelButton)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
//        grayView.snp.makeConstraints{
//            $0.leading.top.equalToSuperview().offset(10)
//            $0.trailing.equalToSuperview().offset(-10)
//            $0.height.equalTo(50)
//        }
//        searchImage.snp.makeConstraints{
//            $0.leading.top.equalToSuperview().offset(15)
//            $0.width.height.equalTo(20)
//        }
//
//        searchText.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(15)
//            $0.leading.equalTo(searchImage.snp.trailing).offset(15)
//        }
//
//        deleteButton.snp.makeConstraints{
//            $0.leading.equalTo(searchText.snp.trailing)
//            $0.top.equalToSuperview()
//        }
//
//        cancelButton.snp.makeConstraints{
//            $0.leading.equalTo(grayView.snp.trailing)
//            $0.top.equalToSuperview()
//        }
    }
}

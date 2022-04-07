import UIKit
import SnapKit

class SearchBarView: UIView{
    
    var delegate: SearchBarDelegate!
    
    var mainView: UIStackView!
    var grayView: UIView!
    
    var searchIcon: UIImageView!
    var textField: UITextField!
    var deleteButton: UIButton!
    var cancelButton: UIButton!
    
    
    init(){
        super.init(frame: .zero)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIStackView()
        mainView.spacing = 10
        
        grayView = UIView()
        grayView.backgroundColor = .lightGray
        grayView.layer.cornerRadius = 10

        searchIcon = UIImageView(image: UIImage(named: "magnifyingGlass.jpeg"))
        
        textField = UITextField()
        textField.placeholder = "Search"
        textField.delegate = self
        
        deleteButton = UIButton()
        deleteButton.setImage(UIImage(named: "close"), for: .normal)
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(clickedDeleteButton), for: .touchUpInside)
        
        cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.isHidden = true
        cancelButton.addTarget(self, action: #selector(clickedCancelButton), for: .touchUpInside)
//        cancelButton.isHidden = true
        
        addSubview(mainView)
        mainView.addArrangedSubview(grayView)
        grayView.addSubview(searchIcon)
        grayView.addSubview(textField)
        grayView.addSubview(deleteButton)
        mainView.addArrangedSubview(cancelButton)
    }
    
    @objc
    func clickedCancelButton(){
        cancelButton.isHidden = true
        deleteButton.isHidden = true
        textField.text = ""
        textField.endEditing(true)
        
        delegate?.replaceViewControllers()
    }
    
    @objc
    func clickedDeleteButton(){
        deleteButton.isHidden = true
        textField.text = ""
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        grayView.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        searchIcon.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(15)
            $0.height.width.equalTo(20)
        }
        
        textField.snp.makeConstraints{
            $0.leading.equalTo(searchIcon.snp.trailing).offset(10)
            $0.trailing.equalTo(deleteButton)
            $0.top.equalToSuperview().offset(15)
        }
        
        deleteButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(17)
            $0.width.height.equalTo(15)
        }
        
        cancelButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
        }
        
    }
}

extension SearchBarView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Begin typing")
        
        cancelButton.isHidden = false
        
        delegate?.replaceViewControllers()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Stopped typing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        deleteButton.isHidden = false
        
        //  Hides the X button if we deleted all characteres
        if(range.lowerBound == 0 && range.upperBound > 0){
            deleteButton.isHidden = true
        }
        
        return true
    }
}

protocol SearchBarDelegate{
    func replaceViewControllers()
}

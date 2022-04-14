import UIKit
import SnapKit
import MovieAppData

class ButtonCell: UIView{
    
    var filter: MovieFilter!
    
    var delegate: ButtonCellDelegate!
        
    var mainView: UIView!
    var button: UIButton!
    
    var buttonUnderLine: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIView()
        
        button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        buttonUnderLine = UIView()
        buttonUnderLine.backgroundColor = UIColor(red: 30.0/255.0, green: 54.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        buttonUnderLine.isHidden = true
                
        addSubview(mainView)
        mainView.addSubview(button)
        button.addSubview(buttonUnderLine)
    }
    
    func set(filter: MovieFilter, isSelected: Bool){        
        self.filter = filter
        button.setTitle(filterToString(filter: filter), for: .selected)
        button.setTitle(filterToString(filter: filter), for: .normal)

        if isSelected{
            button.isSelected = true
            buttonUnderLine.isHidden = false
        }
    }
    
    @objc
    func buttonPress(){

        if button.state.rawValue == 1{
            delegate?.changeButtonStates(clickedButton: filter)
        }
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        button.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        buttonUnderLine.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(button.snp.bottom)
            $0.bottom.equalToSuperview().offset(3)
        }
    }
    
    
    func filterToString(filter: MovieFilter) -> String{
        switch filter {
        case .streaming:
            return "Streaming"
        case .onTv:
            return "On TV"
        case .forRent:
            return "For Rent"
        case .inTheaters:
            return "In theaters"

        // genre
        case .thriller:
            return "Thriller"
        case .horror:
            return "Horror"
        case .comedy:
            return "Comedy"
        case .romanticComedy:
            return "Romantic Comedy"
        case .sport:
            return "Sport"
        case .action:
            return "Action"
        case .sciFi:
            return "SciFi"
        case .war:
            return "War"
        case .drama:
            return "Drama"

        // time filters
        case .day:
            return "Day"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .allTime:
            return "All time"
            
        default:
            return "Unknown"
        }
    }
}

protocol ButtonCellDelegate{
    
    func changeButtonStates(clickedButton: MovieFilter)
    
    
}


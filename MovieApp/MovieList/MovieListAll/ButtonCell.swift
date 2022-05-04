import UIKit
import SnapKit
import MovieAppData

class ButtonCell: UIView{
    
    var genre: Genre!
    
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        
        buttonUnderLine = UIView()
        buttonUnderLine.backgroundColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        buttonUnderLine.isHidden = true
        
        addSubview(mainView)
        mainView.addSubview(button)
        button.addSubview(buttonUnderLine)
    }
    
    func set(genre: Genre, isSelected: Bool){
        self.genre = genre
        button.setTitle(genre.name, for: .selected)
        button.setTitle(genre.name, for: .normal)
        
        if isSelected{
            button.isSelected = true
            buttonUnderLine.isHidden = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
    }
    
    @objc
    func buttonPress(){
        
        if button.state.rawValue == 1{
            delegate?.changeButtonStates(clickedButton: genre)
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
    
    func changeButtonStates(clickedButton: Genre)
    
    
}


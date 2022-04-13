import UIKit
import SnapKit
import MovieAppData

class ButtonCell: UIView{
    
    var filter: MovieFilter!
        
    var mainView: UIView!
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
        mainView = UIView()
        
        button = UIButton()
        
        backgroundColor = .red
        
        addSubview(mainView)
        mainView.addSubview(button)
    }
    
    func set(filter: MovieFilter){
        self.filter = filter
        button.setTitle(filterToString(filter: filter), for: .normal)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        button.snp.makeConstraints{
            $0.edges.equalToSuperview()
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



import UIKit
import SnapKit
import MovieAppData

class MovieListSearchingCell: UICollectionViewCell{
    static let reuseIdentifier = String(describing: MovieListSearchingViewController.self)
    
    var movie: MovieModel!
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        backgroundColor = .red
        
        label = UILabel()
        label.text = "aaaaaaa"
        
        addSubview(label)
    }
    
    func addConstraints(){
        label.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func set(movie: MovieModel){
        self.movie = movie
        label.text = movie.title
    }
}



import UIKit
import SnapKit
import MovieAppData

class MovieListSearchingCell: UICollectionViewCell{
    static let reuseIdentifier = String(describing: MovieListSearchingViewController.self)
    
    var movie: MovieModel!
    
    var mainView: UIView!
    
    var imageView: UIImageView!
    var textView: UIView!
    
    var title: UILabel!
    var movieDescription: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        
        mainView = UIView()
        mainView.layer.cornerRadius = 20
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = .white
        
        imageView = UIImageView(image: nil)
        textView = UIView()
        
        title = UILabel()
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        movieDescription = UILabel()
        movieDescription.numberOfLines = 0
        movieDescription.adjustsFontSizeToFitWidth = true
        
        addSubview(mainView)
        
        mainView.addSubview(imageView)
        mainView.addSubview(textView)
        
        textView.addSubview(title)
        textView.addSubview(movieDescription)
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }

        textView.snp.makeConstraints{
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing)
        }
        
        title.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview()
        }

        movieDescription.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(title.snp.bottom).offset(10)
        }
    }
    
    func set(movie: MovieModel){
        self.movie = movie
        title.text = movie.title + " (" + String(movie.year) + ")"
        movieDescription.text = movie.description
        
        let url = URL(string: movie.imageUrl)
        guard let url=url else {
            fatalError()
        }
        load(url: url)
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
}



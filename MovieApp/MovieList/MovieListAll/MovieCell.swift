import UIKit
import SnapKit
import MovieAppData

class MovieCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    
    var heartViewHolder: UIView!
    var heartView: UIImageView!
    var imageView: UIImageView!
    
    var moviesRepository: MoviesRepository!
    
    var movie: MovieViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        
        
        heartViewHolder = UIView()
        heartViewHolder.backgroundColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 0.6)
        heartViewHolder.layer.masksToBounds = true
        heartViewHolder.layer.cornerRadius = 32/2
        
        
        heartView = UIImageView(image: UIImage(named: "white"))
        heartView.contentMode = .scaleToFill
        
        imageView = UIImageView(image: nil)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleFavourite))
        heartViewHolder.isUserInteractionEnabled = true
        heartViewHolder.addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(imageView)
        addSubview(heartViewHolder)
        heartViewHolder.addSubview(heartView)
    }
    
    @objc
    func toggleFavourite(){
        moviesRepository.toggleFavourite(movieId: movie.id)
        
        movie = moviesRepository.getMovie(id: movie.id)
        adjustHeartView()
    }
    
    func set(movie: MovieViewModel, moviesRepository: MoviesRepository){
        self.movie = movie
        self.moviesRepository = moviesRepository
        
        adjustHeartView()
        DispatchQueue.global().async {
            moviesRepository.loadImage(urlStr: IMAGES_BASE_URL + movie.poster_path, completionHandler: {image in
                self.imageView.image = image
            })
        }
        
        
    }
    
    func adjustHeartView(){
        if movie.favourite == true{
            heartView.image = UIImage(systemName: "heart.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
        else{
            heartView.image = UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
    
    func addConstraints(){
        heartViewHolder.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(5)
            $0.width.height.equalTo(32)
        }
        
        heartView.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(32/2 - 8)
            $0.height.width.equalTo(16)
        }
        
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

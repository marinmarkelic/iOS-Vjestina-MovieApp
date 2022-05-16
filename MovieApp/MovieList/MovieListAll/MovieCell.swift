import UIKit
import SnapKit
import MovieAppData

class MovieCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    
    var heartViewHolder: UIView!
    var heartView: UIImageView!
    var imageView: UIImageView!
    
    
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
        
        
        
        let heart = UIImage(named: "heart")
        
        heartViewHolder = UIView()
        heartViewHolder.backgroundColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 0.6)
        heartViewHolder.layer.masksToBounds = true
        heartViewHolder.layer.cornerRadius = 32/2
        
        
        heartView = UIImageView(image: heart)
        heartView.contentMode = .scaleToFill
        
        imageView = UIImageView(image: nil)
        
        addSubview(imageView)
        addSubview(heartViewHolder)
        heartViewHolder.addSubview(heartView)
    }
    
    func set(movie: MovieViewModel){
        self.movie = movie
        
        DataLoader().loadImage(urlStr: IMAGES_BASE_URL + movie.poster_path, completionHandler: {image in
            self.imageView.image = image
        })
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

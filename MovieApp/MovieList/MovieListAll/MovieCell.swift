import UIKit
import SnapKit
import MovieAppData

class MovieCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    
    var heartViewHolder: UIView!
    var heartView: UIImageView!
    var imageView: UIImageView!
    
    
    var movie: MovieModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        let heart = UIImage(named: "heart")
        
        heartViewHolder = UIView()
        heartViewHolder.backgroundColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 0.6)
        heartViewHolder.layer.masksToBounds = true
        heartViewHolder.layer.cornerRadius = 32/2
        
        
        heartView = UIImageView(image: heart)
        heartView.contentMode = .scaleToFill
        
        imageView = UIImageView(image: nil)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(heartViewHolder)
        heartViewHolder.addSubview(heartView)
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
    
    func set(movie: MovieModel){
        self.movie = movie
        
        //        title.text = movie.title
        let url = URL(string: movie.imageUrl)
        guard let url=url else {
            fatalError()
        }
        load(url: url)
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

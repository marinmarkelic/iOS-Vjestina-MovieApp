import UIKit
import SnapKit
import MovieAppData

class MovieCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    
    
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
        
        imageView = UIImageView(image: nil)
        imageView.layer.cornerRadius = 10        
        
        
        addSubview(imageView)
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
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

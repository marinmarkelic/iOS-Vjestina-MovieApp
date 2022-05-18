import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
    
    var movieId: Int
    var favourite: Bool
    
    var dataLoader: DataLoaderProtocol = DataLoader()
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var mainInfo: MainInfoView!
    var overview: OverviewView!
    
    
    init(movieId: Int, favourite: Bool){
        self.movieId = movieId
        self.favourite = favourite
                
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        MoviesRepository().getMovieDetails(movieId: movieId, completionHandler: {details in
            let movieDetails = details
            
            self.overview.reloadData(movie: movieDetails)
            self.mainInfo.reloadData(movie: movieDetails)
            
            MoviesRepository().loadImage(urlStr: IMAGES_BASE_URL + movieDetails.backdrop_path, completionHandler: { image in
                self.mainInfo.bgImage.image = image
                
                self.dataLoader.addMovieBackdropImage(movieBackdropImage: MovieBackdropImage(id: self.movieId, image: image))
                
            })
            
//            if self.dataLoader.movieBackdropImages.contains(MovieBackdropImage(id: self.movieId, image: nil)){
//                if let index = self.dataLoader.movieBackdropImages.firstIndex(of: MovieBackdropImage(id: self.movieId, image: nil)){
//                    self.mainInfo.bgImage.image = self.dataLoader.movieBackdropImages[index].image
//                }
//            }
//            else{
//                self.dataLoader.loadImage(urlStr: IMAGES_BASE_URL + movieDetails.backdrop_path, completionHandler: { image in
//                    self.mainInfo.bgImage.image = image
//
//                    self.dataLoader.addMovieBackdropImage(movieBackdropImage: MovieBackdropImage(id: self.movieId, image: image))
//
//                })
//            }
        })

        
        buildViews()
        addConstraints()
    }
    
    private func buildViews(){
        view.backgroundColor = UIColor(red: 11.0/256.0, green: 37.0/256.0, blue: 63.0/256.0, alpha: 1.0)
        
        scrollView = UIScrollView()
        contentView = UIView()
        
        
        mainInfo = MainInfoView(movieId: movieId, favourite: favourite)
        overview = OverviewView()
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(mainInfo)
        contentView.addSubview(overview)
        
    }
    
    private func addConstraints(){
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainInfo.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide).dividedBy(2)
        }
        
        overview.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mainInfo.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide).dividedBy(2)
        }
    }
}

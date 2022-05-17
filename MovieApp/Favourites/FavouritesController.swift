import UIKit
import SnapKit

class FavouritesController: UIViewController{
    
    var mainView: UIView!
    
    var label: UILabel!
    
    var delegate: TopicCollectionViewDelegate!
    
    var moviesRepository: MoviesRepository!
    
    var collectionViewContainer: UIView!
    var movieCollectionViewLayout: UICollectionViewFlowLayout!
    var movieCollectionView: UICollectionView!


    init() {
        super.init(nibName: nil, bundle: nil)
        
        moviesRepository = MoviesRepository()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        buildViews()
        addConstraints()
        configureCollectionView()
    }
    
    func buildViews(){        
        mainView = UIView()
        mainView.backgroundColor = .white
        
        label = UILabel()
        label.text = "Favourites"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        
        collectionViewContainer = UIView()
        collectionViewContainer.backgroundColor = .yellow
        
        movieCollectionViewLayout = UICollectionViewFlowLayout()
        movieCollectionViewLayout.scrollDirection = .horizontal
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: movieCollectionViewLayout)
        
        view.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(collectionViewContainer)
    }
    
    func configureCollectionView() {
        movieCollectionView.showsHorizontalScrollIndicator = false
        
        movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        label.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
        }
        
        collectionViewContainer.snp.makeConstraints{
            $0.top.equalTo(label).offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension FavouritesController: UICollectionViewDelegate{
    
}

extension FavouritesController: UICollectionViewDelegateFlowLayout {
    
    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - 2 * 10) / 3
        let itemHeight = CGFloat(collectionViewContainer.frame.height / 1.4)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension FavouritesController: UICollectionViewDataSource {
    
//  onClick for collection view cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(movies.sorted(by: {$0.original_title > $1.original_title})[indexPath.row].original_title)
        
        guard let delegate = delegate else{
            return
        }
        
//        delegate.movieSelected(movieId: movies.filter({ $0.genre_ids.contains(genre.id) }).sorted(by: {$0.original_title > $1.original_title})[indexPath.row].id)
        delegate.movieSelected(movieId: moviesRepository.getFavouriteMovies()[indexPath.row].id)

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesRepository.getFavouriteMovies().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
        else {
            fatalError()
        }
        
        let movie = moviesRepository.getFavouriteMovies()[indexPath.row]

        
        cell.set(movie: movie, moviesRepository: moviesRepository)
                
        return cell
    }
}

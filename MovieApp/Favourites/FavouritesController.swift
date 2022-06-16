import UIKit
import SnapKit

class FavouritesController: UIViewController, MoviesRepositoryDelegate{

    var mainView: UIView!
    
    var label: UILabel!
    
    var delegate: MovieSelectedDelegate!
    
    var moviesRepository: MoviesRepository!
    
    var collectionViewContainer: UIView!
    var movieCollectionViewLayout: UICollectionViewFlowLayout!
    var movieCollectionView: UICollectionView!


    init(movieSelectedDelegate: MovieSelectedDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        delegate = movieSelectedDelegate
        
        moviesRepository = MoviesRepository()
        moviesRepository.delegate = self
    }
    
    func reloadData() {
        movieCollectionView.reloadData()
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
        movieCollectionViewLayout.scrollDirection = .vertical
        
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: movieCollectionViewLayout)
        movieCollectionView.showsHorizontalScrollIndicator = false
        movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        view.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(collectionViewContainer)
        collectionViewContainer.addSubview(movieCollectionView)
    }
    
    func configureCollectionView() {
        
    }
    
    func addConstraints(){
        mainView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        label.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(50)
        }
        
        collectionViewContainer.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.bottom.equalToSuperview().offset(-18)
        }
        
        movieCollectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
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
//        let itemHeight = CGFloat(collectionViewContainer.frame.height / 1.4)
        let itemHeight = itemWidth * 1.4
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension FavouritesController: UICollectionViewDataSource {
    
//  onClick for collection view cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(movies.sorted(by: {$0.original_title > $1.original_title})[indexPath.row].original_title)
        
        guard let delegate = delegate else{
            print("nil")
            return
        }
        
//        delegate.movieSelected(movieId: movies.filter({ $0.genre_ids.contains(genre.id) }).sorted(by: {$0.original_title > $1.original_title})[indexPath.row].id)
        print("click")
        delegate.movieSelected(movieId: moviesRepository.getFavouriteMovies()[indexPath.row].id, favourite: moviesRepository.getFavouriteMovies()[indexPath.row].favourite)

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numofitems")
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
        
        print("favorite: \(movie)")
                
        return cell
    }
}

import UIKit
import SnapKit
import MovieAppData

class MovieListSearchingViewController: UIViewController, SearchBarInputDelegate, MoviesRepositoryDelegate{
    func reloadData() {
        
    }
    
    var movieListSearchingViewControllerDelegate: MovieListSearchingViewControllerDelegate!
    var movieSelectedDelegate: MovieSelectedDelegate!
    
    var collectionViewLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    
    var searchBarText = ""
    
    var repo: MoviesRepository!
    
    init(movieSelectedDelegate: MovieSelectedDelegate, movieListSearchingViewControllerDelegate: MovieListSearchingViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.movieSelectedDelegate = movieSelectedDelegate
        self.movieListSearchingViewControllerDelegate = movieListSearchingViewControllerDelegate
        
        repo = MoviesRepository()
        repo.delegate = self
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
        
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 15
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
    
    func addConstraints(){
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureCollectionView() {
        //ExampleCollectionViewCell, String
        collectionView.register(MovieListSearchingCell.self, forCellWithReuseIdentifier: MovieListSearchingCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    func inputChanged(newInput: String){
        searchBarText = newInput
        
        
        collectionView.reloadData()
    }
    
    //  Resizes collection view cells on rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(
            alongsideTransition: { _ in self.collectionView.collectionViewLayout.invalidateLayout() },
            completion: { _ in }
        )
    }
}

extension MovieListSearchingViewController: UICollectionViewDelegate{
    
}

extension MovieListSearchingViewController: UICollectionViewDelegateFlowLayout {
    
    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        if UIDevice.current.orientation.isPortrait{
            let itemWidth = collectionView.frame.width - 20
            //        let itemDimension = (collectionViewWidth - 2 * 10) / 3
            let itemHeight = CGFloat(view.frame.height / 3)
            
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else{
            let itemWidth = collectionView.frame.width - 20
            let itemHeight = CGFloat(view.frame.height - 40)
            
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
}

extension MovieListSearchingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movieSelectedDelegate = movieSelectedDelegate,
              let movieListSearchingViewControllerDelegate = movieListSearchingViewControllerDelegate else{
                  return
              }
        
        let movies: [MovieViewModel]
        
        if searchBarText.isEmpty{
            movies = repo.getLoadedMovies()
        }
        else{
            movies = repo.getLoadedMovies(withText: searchBarText)
        }
        
        movieSelectedDelegate.movieSelected(movieId: movies[indexPath.row].id, favourite: movies[indexPath.row].favourite)
        movieListSearchingViewControllerDelegate.selectedMovie()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchBarText.isEmpty{
            return repo.getLoadedMovies().count
        }
        
        return repo.getLoadedMovies(withText: searchBarText).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListSearchingCell.reuseIdentifier, for: indexPath) as? MovieListSearchingCell
        else {
            fatalError()
        }
        
        let movie: MovieViewModel
        if searchBarText.isEmpty{
            movie = repo.getLoadedMovies()[indexPath.row]
        }
        else{
            movie = repo.getLoadedMovies(withText: searchBarText)[indexPath.row]
        }
        
        cell.set(movie: movie)
        
        return cell
    }
}

protocol MovieListSearchingViewControllerDelegate{
    //    resets search bar when we click on a movie
    func selectedMovie()
}

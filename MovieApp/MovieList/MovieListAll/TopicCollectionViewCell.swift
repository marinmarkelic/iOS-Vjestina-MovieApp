import UIKit
import SnapKit
import MovieAppData


class TopicCollectionViewCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    var cellCategory: Group!
    var genres: [MovieGenreViewModel]!
    var genre: MovieGenreViewModel!
    var movies: [MovieViewModel] = []
    
    var delegate: MovieSelectedDelegate!
    
    var moviesRepository: MoviesRepository!
    
    var mainView: UIView!
    var title: UILabel!
    
    var collectionViewsContainer: UIView!
    
    var buttonStackViewScrollView: UIScrollView!
    var buttonContentView: UIView!
    var buttonStackView: UIStackView!
    
    var movieCollectionViewLayout: UICollectionViewFlowLayout!
    var movieCollectionView: UICollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        addConstraints()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        mainView = UIView()
        
        title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        title.textColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        
        
        collectionViewsContainer = UIView()
        
        buttonStackViewScrollView = UIScrollView()
        buttonStackViewScrollView.showsHorizontalScrollIndicator = false
        
        buttonContentView = UIView()
        
        buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillProportionally
        buttonStackView.spacing = 15
        
        movieCollectionViewLayout = UICollectionViewFlowLayout()
        movieCollectionViewLayout.scrollDirection = .horizontal
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: movieCollectionViewLayout)
        
        addSubview(mainView)
        mainView.addSubview(title)
        mainView.addSubview(collectionViewsContainer)
        
        collectionViewsContainer.addSubview(buttonStackViewScrollView)
        buttonStackViewScrollView.addSubview(buttonContentView)
        buttonContentView.addSubview(buttonStackView)
        
        collectionViewsContainer.addSubview(movieCollectionView)
    }
    
    func configureCollectionView() {
        movieCollectionView.showsHorizontalScrollIndicator = false
        
        movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    func set(movieGroup: Group, moviesRepository: MoviesRepository, movieSelectedDelegate: MovieSelectedDelegate) {
        cellCategory = movieGroup
        
        self.moviesRepository = moviesRepository
        genres = moviesRepository.getLoadedGenres()
        
        delegate = movieSelectedDelegate
        
        title.text = groupToString(cellCategory)
        
        
        for g in genres {
            let cell = ButtonCell()
            //  highlight only first cell at the beginning
            cell.set(genre: g, isSelected: genres[0].name == g.name)
            cell.delegate = self
            buttonStackView.addArrangedSubview(cell)
        }
        
        if genres.count > 0{
            genre = genres[0]
        }
        
        loadMovies()
        
        
        print("topic cell view reload")
        movieCollectionView.reloadData()
    }
    
    func loadMovies(){
        guard let genre=genre else{
            return
        }
        
        switch cellCategory {
        case .popular:
            movies = moviesRepository.getLoadedMovies(group: cellCategory, genreId: genre.id)
        case .trending:
            movies = moviesRepository.getLoadedMovies(group: cellCategory, genreId: genre.id)
        case .topRated:
            movies = moviesRepository.getLoadedMovies(group: cellCategory, genreId: genre.id)
        case .recommended:
            movies = moviesRepository.getLoadedMovies(group: cellCategory, genreId: genre.id)
        case .none:
            movies = []
        }
    }
    
    
    
    func addConstraints() {
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        title.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        collectionViewsContainer.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(title.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
        
        buttonStackViewScrollView.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(movieCollectionView.snp.top)
        }
        
        buttonContentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        
        movieCollectionView.snp.makeConstraints{
            $0.top.equalTo(buttonStackView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension TopicCollectionViewCell: UICollectionViewDelegate{
    
}

extension TopicCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - 2 * 10) / 3
        let itemHeight = CGFloat(collectionViewsContainer.frame.height / 1.4)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension TopicCollectionViewCell: UICollectionViewDataSource {
    
    //  onClick for collection view cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else{
            return
        }
        
        delegate.movieSelected(movieId: movies[indexPath.row].id, favourite: movies[indexPath.row].favourite)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
        else {
            fatalError()
        }
        
        let movie = movies[indexPath.row]
        
        
        cell.set(movie: movie, moviesRepository: moviesRepository)
        
        return cell
    }
}

extension TopicCollectionViewCell: ButtonCellDelegate{
    
    func changeButtonStates(clickedButton: MovieGenreViewModel) {
        for view in buttonStackView.subviews {
            view.removeFromSuperview()
        }
        
        genre = clickedButton
        print("--\(genre.id)")
        
        for g in genres {
            let cell = ButtonCell()
            //  highlight only first cell at the beginning
            cell.set(genre: g, isSelected: g.name == clickedButton.name ? true : false)
            cell.delegate = self
            buttonStackView.addArrangedSubview(cell)
        }
        
        loadMovies()
        movieCollectionView.reloadData()
    }
}

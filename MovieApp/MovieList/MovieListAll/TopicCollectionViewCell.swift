import UIKit
import SnapKit
import MovieAppData


class TopicCollectionViewCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    var cellCategory: Group!
    var genres: [MovieGenreViewModel]!
    var genre: MovieGenreViewModel!
    var movies: [MovieViewModel] = []
        
    var delegate: TopicCollectionViewDelegate!
    
    var moviesRepository: MoviesRepository!
        
    var mainView: UIView!
    var title: UILabel!
    
    //    var buttonCollectionView: UICollectionView!
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
    
    func set(movieGroup: Group, moviesRepository: MoviesRepository, topicCollectionViewCellDelegate: TopicCollectionViewDelegate) {
        cellCategory = movieGroup
        
        self.moviesRepository = moviesRepository
        genres = moviesRepository.getLoadedGenres()
        
        delegate = topicCollectionViewCellDelegate
        
        switch movieGroup {
        case .popular:
            movies = moviesRepository.getLoadedMovies(group: movieGroup)
        case .trending:
            movies = moviesRepository.getLoadedMovies(group: movieGroup)
        case .topRated:
            movies = moviesRepository.getLoadedMovies(group: movieGroup)
        case .recommended:
            movies = moviesRepository.getLoadedMovies(group: movieGroup)
        }
        
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
        

        print("topic cell view reload")
        movieCollectionView.reloadData()
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
//        print(movies.sorted(by: {$0.original_title > $1.original_title})[indexPath.row].original_title)
        
        guard let delegate = delegate else{
            return
        }
        
//        delegate.movieSelected(movieId: movies.filter({ $0.genre_ids.contains(genre.id) }).sorted(by: {$0.original_title > $1.original_title})[indexPath.row].id)
        delegate.movieSelected(movieId: movies[indexPath.row].id)

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
        
//        let movie = movies.filter({ $0.genre_ids.contains(genre.id) }).sorted(by: {$0.original_title > $1.original_title})[indexPath.row]
        let movie = movies[indexPath.row]

        
        cell.set(movie: movie, moviesRepository: moviesRepository)
        
//        if movies.count > 0{
//            if let dataLoader=dataLoader{
//
//                //  If the image is already fetched get it from moviePosterImages else fetch it and store it in moviePosterImages
//                if dataLoader.moviePosterImages.contains(MoviePosterImage(id: movie.id, image: nil)){
//                    if let index = dataLoader.moviePosterImages.firstIndex(of: MoviePosterImage(id: movie.id, image: nil)){
//                        cell.imageView.image = dataLoader.moviePosterImages[index].image
//                    }
//                }
//                else{
//                    dataLoader.loadImage(urlStr: IMAGES_BASE_URL + movie.poster_path, completionHandler: {image in
//                        cell.imageView.image = image
//
//                        dataLoader.addMoviePosterImage(moviePosterImage: MoviePosterImage(id: movie.id, image: image))
//                    })
//                }
//            }
//        }
                
        return cell
    }
}

extension TopicCollectionViewCell: ButtonCellDelegate{
    
    func changeButtonStates(clickedButton: MovieGenreViewModel) {
        for view in buttonStackView.subviews {
            view.removeFromSuperview()
            //            buttonStackView.removeArrangedSubview(view)
        }
        
        genre = clickedButton
        
        for g in genres {
            let cell = ButtonCell()
            //  highlight only first cell at the beginning
            cell.set(genre: g, isSelected: g.name == clickedButton.name ? true : false)
            cell.delegate = self
            buttonStackView.addArrangedSubview(cell)
        }
        
        movieCollectionView.reloadData()
    }
}

protocol TopicCollectionViewDelegate{
    func movieSelected(movieId: Int)
}

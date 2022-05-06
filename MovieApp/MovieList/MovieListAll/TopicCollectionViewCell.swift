import UIKit
import SnapKit
import MovieAppData


//  Rename movieGroup to cellCategory


class TopicCollectionViewCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    var cellMovieGroup: Category!
    var genres: [Genre]!
    var movies: [MovieResult] = []
    
    var dataLoader: DataLoaderProtocol!
    
    var delegate: TopicCollectionViewDelegate!
        
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
    
    func set(movieGroup: Category, dataLoader: DataLoaderProtocol, topicCollectionViewCellDelegate: TopicCollectionViewDelegate) {
        cellMovieGroup = movieGroup
        
        genres = dataLoader.genres
        self.dataLoader = dataLoader
        delegate = topicCollectionViewCellDelegate
        
        switch movieGroup {
        case .popular:
            movies = dataLoader.popularMovies
        case .trending:
            movies = dataLoader.trendingMovies
        case .topRated:
            movies = dataLoader.topRatedMovies
        case .recommended:
            movies = dataLoader.recommendedMovies
        }
        
        title.text = categoryToString(cellMovieGroup)
        

            for g in genres {
                let cell = ButtonCell()
                //  highlight only first cell at the beginning
                cell.set(genre: g, isSelected: genres[0].name == g.name)
                cell.delegate = self
                buttonStackView.addArrangedSubview(cell)
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
        print(movies.sorted(by: {$0.original_title > $1.original_title})[indexPath.row].original_title)
        
        guard let delegate = delegate else{
            return
        }
        
        delegate.movieSelected(movieId: movies.sorted(by: {$0.original_title > $1.original_title})[indexPath.row].id)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
        else {
            fatalError()
        }
        
        let movie = movies.sorted(by: {$0.original_title > $1.original_title})[indexPath.row]
        
        cell.set(movie: movie)
        
        if movies.count > 0{
            if let dataLoader=dataLoader{
                dataLoader.loadImage(urlStr: IMAGES_BASE_URL + movie.poster_path, completionHandler: {image in
                    cell.imageView.image = image
                })
            }
        }
                
        return cell
    }
}

extension TopicCollectionViewCell: ButtonCellDelegate{
    
    func changeButtonStates(clickedButton: Genre) {
        for view in buttonStackView.subviews {
            view.removeFromSuperview()
            //            buttonStackView.removeArrangedSubview(view)
        }
        
//        let titleList = cellMovieGroup.filters
        
        
        for g in genres {
            let cell = ButtonCell()
            //  highlight only first cell at the beginning
            cell.set(genre: g, isSelected: g.name == clickedButton.name ? true : false)
            cell.delegate = self
            buttonStackView.addArrangedSubview(cell)
        }
        
    }
}

protocol TopicCollectionViewDelegate{
    func movieSelected(movieId: Int)
}

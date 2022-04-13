import UIKit
import SnapKit
import MovieAppData

class TopicCollectionViewCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: TopicCollectionViewCell.self)
    var cellMovieGroup: MovieGroup!
    
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
        title.textColor = UIColor(red: 30.0/255.0, green: 54.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        
        
        collectionViewsContainer = UIView()
        
        buttonStackViewScrollView = UIScrollView()
        buttonStackViewScrollView.showsHorizontalScrollIndicator = false
        
        buttonContentView = UIView()
        
        buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .equalSpacing
        buttonStackView.spacing = 10

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
    
    func set(movieGroup: MovieGroup) {
        cellMovieGroup = movieGroup
        
        switch movieGroup {
        case .popular:
            title.text = "What's popular"
        case .freeToWatch:
            title.text = "Free to Watch"
        case .trending:
            title.text = "Trending"
        case .topRated:
            title.text = "Top rated"
        case .upcoming:
            title.text = "Upcoming"
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
            $0.top.equalTo(title.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
        
        buttonStackViewScrollView.snp.makeConstraints{
            buttonStackViewScrollView.backgroundColor = .green
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(movieCollectionView.snp.top)
        }
        
        buttonContentView.snp.makeConstraints{
            $0.leading.top.bottom.trailing.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        
        movieCollectionView.snp.makeConstraints{
            movieCollectionView.backgroundColor = .red
            $0.top.equalTo(buttonStackView.snp.bottom).offset(50)
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
        let itemHeight = CGFloat(collectionViewsContainer.frame.height / 1.8)

        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension TopicCollectionViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let titleList = cellMovieGroup.filters

        
        for e in titleList {
            let cell = ButtonCell()
            //  highlight only first cell at the beginning
            cell.set(filter: e, isSelected: titleList.firstIndex(of: e) == 0)
            cell.delegate = self
            buttonStackView.addArrangedSubview(cell)
        }
        
        let movies = Movies.all()
                
        return movies.filter({$0.group.contains(cellMovieGroup)}).count
        
//        return cellMovieGroup.filters[0]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
        else {
            fatalError()
        }
        
        let movies = Movies.all()
        
        cell.set(movie: movies.filter{$0.group.contains(cellMovieGroup)}.sorted(by: {$0.title > $1.title})[indexPath.row])

        return cell
    }
}

extension TopicCollectionViewCell: ButtonCellDelegate{
    
    func changeButtonStates(clickedButton: MovieFilter) {
        for view in buttonStackView.subviews {
            view.removeFromSuperview()
//            buttonStackView.removeArrangedSubview(view)
        }
        
        let titleList = cellMovieGroup.filters

        
        for e in titleList {
            let cell = ButtonCell()
            //  highlight only first cell at the beginning
            cell.set(filter: e, isSelected: e == clickedButton ? true : false)
            cell.delegate = self
            buttonStackView.addArrangedSubview(cell)
        }

    }
}

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
    var buttonCollectionViewLayout: UICollectionViewFlowLayout!
    var buttonCollectionView: UICollectionView!
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
        
        buttonCollectionViewLayout = UICollectionViewFlowLayout()
        buttonCollectionViewLayout.scrollDirection = .horizontal
        buttonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: buttonCollectionViewLayout)

        movieCollectionViewLayout = UICollectionViewFlowLayout()
        movieCollectionViewLayout.scrollDirection = .horizontal
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: movieCollectionViewLayout)
        
        addSubview(mainView)
        mainView.addSubview(title)
        mainView.addSubview(collectionViewsContainer)
        collectionViewsContainer.addSubview(buttonCollectionView)
        collectionViewsContainer.addSubview(movieCollectionView)
    }
    
    func configureCollectionView() {
        buttonCollectionView.showsHorizontalScrollIndicator = false
        
        buttonCollectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.reuseIdentifier)
        buttonCollectionView.dataSource = self
        buttonCollectionView.delegate = self
        
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
            $0.top.equalTo(title.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        buttonCollectionView.snp.makeConstraints{
            buttonCollectionView.backgroundColor = .red
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(movieCollectionView.snp.top)
        }
        
        movieCollectionView.snp.makeConstraints{
//            $0.top.equalTo(buttonCollectionView.snp.bottom)
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
        let itemHeight = CGFloat(collectionViewsContainer.frame.height)

        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension TopicCollectionViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.buttonCollectionView{

            if cellMovieGroup == .popular {
                return 4
            }
            else{
                return 2
            }
        }
        
        let movies = Movies.all()
                
        return movies.filter({$0.group.contains(cellMovieGroup)}).count
        
//        return cellMovieGroup.filters[0]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.buttonCollectionView{
            print("done")

            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseIdentifier, for: indexPath) as? ButtonCell
            else {
                fatalError()
            }

            
            if cellMovieGroup == .popular {
                cell.set(title: "a")
                return cell
            }
            else{
                cell.set(title: "b")
                return cell
            }
        }
        
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

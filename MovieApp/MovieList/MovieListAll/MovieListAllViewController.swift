import UIKit
import SnapKit
import MovieAppData

class MovieListAllViewController: UIViewController{
    
    var collectionViewLayout: UICollectionViewFlowLayout!
    public var collectionView: UICollectionView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        collectionViewLayout.minimumLineSpacing = 25
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
    
    func addConstraints(){
        collectionView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func configureCollectionView() {
        //ExampleCollectionViewCell, String
        collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MovieListAllViewController: UICollectionViewDelegate{
    
}

extension MovieListAllViewController: UICollectionViewDelegateFlowLayout {
    
    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemWidth = collectionView.frame.width
        //        let itemDimension = (collectionViewWidth - 2 * 10) / 3
        let itemHeight = CGFloat(view.frame.height / 2.2)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension MovieListAllViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var groupSet = Set<MovieGroup>()
        let movies = Movies.all()
        
        movies
            .map { $0.group }
            .flatMap { $0 }
            .forEach {
                groupSet.insert($0)
            }
        
        return groupSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.reuseIdentifier, for: indexPath) as? TopicCollectionViewCell
        else {
            fatalError()
        }
        
        let groupArray = [MovieGroup.popular, MovieGroup.freeToWatch, MovieGroup.trending, MovieGroup.topRated, MovieGroup.upcoming]
        
        cell.set(movieGroup: groupArray[indexPath.row])
        
        return cell
    }
}

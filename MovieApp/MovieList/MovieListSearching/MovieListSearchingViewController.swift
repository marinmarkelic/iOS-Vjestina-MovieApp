import UIKit
import SnapKit
import MovieAppData

class MovieListSearchingViewController: UIViewController, SearchBarInputDelegate{
    
    
    var collectionViewLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    
    var searchBarText = ""
    
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
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsVerticalScrollIndicator = false
        
        
        view.addSubview(collectionView)
    }
    
    func addConstraints(){
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
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
        let itemWidth = collectionView.frame.width - 20
        //        let itemDimension = (collectionViewWidth - 2 * 10) / 3
        let itemHeight = CGFloat(view.frame.height / 3)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension MovieListSearchingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movies = Movies.all()
        
        return movies.filter({
            if searchBarText.isEmpty{
                return true
            }
            
            return $0.title.lowercased().contains(searchBarText.lowercased())
        }).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListSearchingCell.reuseIdentifier, for: indexPath) as? MovieListSearchingCell
        else {
            fatalError()
        }
        let movies = Movies.all()

        let movie = movies.filter({
            if searchBarText.isEmpty{
                return true
            }
            
            return $0.title.lowercased().contains(searchBarText.lowercased())
        }).sorted(by: {$0.title > $1.title})[indexPath.row]
        
        cell.set(movie: movie)
                
        return cell
    }
}

//extension SearchBarInputDelegate{
//
//}

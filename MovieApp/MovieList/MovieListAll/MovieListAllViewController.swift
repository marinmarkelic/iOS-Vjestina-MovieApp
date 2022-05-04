import UIKit
import SnapKit
import MovieAppData

class MovieListAllViewController: UIViewController{
    
    var collectionViewLayout: UICollectionViewFlowLayout!
    public var collectionView: UICollectionView!
    var networkService: NetworkService!
    var genres: [Genre]!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService = NetworkService()
        
        buildViews()
        addConstraints()
        fetchGenres()
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
    
    //    fetches all genres and then creates collection view cells
    func fetchGenres(){
        
        genres = []
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=b6430e3b7d34547084b0acc97fe5b8a5") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NetworkService().executeUrlRequest(request){ (result: Result<Genres, RequestError>) in
            
            switch result {
            case .success(let value):
                print("success")
                self.genres = value.genres
                
                self.collectionView.reloadData()
            case .failure(let error):
                RequestErrorHandle(error)
            }
        }
    }
    
    func configureCollectionView() {
        //ExampleCollectionViewCell, String
        collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
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

extension MovieListAllViewController: UICollectionViewDelegate{
    
}

extension MovieListAllViewController: UICollectionViewDelegateFlowLayout {
    
    //postavlja dimenziju celija
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if UIDevice.current.orientation.isPortrait{
            let itemWidth = collectionView.frame.width
            let itemHeight = CGFloat(view.frame.height / 2.2)
            
            return CGSize(width: itemWidth, height: itemHeight)
            
        }
        else{
            let itemWidth = collectionView.frame.width - 80
            let itemHeight = CGFloat(view.frame.height - 40)
            
            return CGSize(width: itemWidth, height: itemHeight)
        }
        
    }
}

extension MovieListAllViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        var groupSet = Set<MovieGroup>()
        //        let movies = Movies.all()
        //
        //        movies
        //            .map { $0.group }
        //            .flatMap { $0 }
        //            .forEach {
        //                groupSet.insert($0)
        //            }
        //
        //
        //
        //        return groupSet.count
        
        return allCategories().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.reuseIdentifier, for: indexPath) as? TopicCollectionViewCell
        else {
            fatalError()
        }
        
        let groupArray = [MovieGroup.popular, MovieGroup.freeToWatch, MovieGroup.trending, MovieGroup.topRated, MovieGroup.upcoming]
        
        cell.set(movieGroup: allCategories()[indexPath.row], genres: genres)
        
        return cell
    }
}

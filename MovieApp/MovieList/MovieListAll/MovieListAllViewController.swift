import UIKit
import SnapKit
import MovieAppData

class MovieListAllViewController: UIViewController, MoviesRepositoryDelegate{
    
    var collectionViewLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var networkService: NetworkService!
    var topicCollectionViewCellDelegate: TopicCollectionViewDelegate!
    
    var moviesRepository: MoviesRepository!
    
    init(moviesRepository: MoviesRepository, topicCollectionViewCellDelegate: TopicCollectionViewDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.moviesRepository = moviesRepository
        moviesRepository.delegate = self
        
        moviesRepository.fetchData(completionHandler: {
            self.dataLoaded()
        })
        
        self.topicCollectionViewCellDelegate = topicCollectionViewCellDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
//        imageView.image = UIImage(named: "tmdbLogo.svg")
//        navigationItem.titleView = imageView
        
        networkService = NetworkService()
                
        buildViews()
        addConstraints()
        configureCollectionView()
        
        networkService.hasConnection(completionHandler: {
            if !$0{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "No internet connection", message: nil, preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    func dataLoaded(){
        collectionView.reloadData()
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
    
    func reloadData(){
        print("delegate reloading")
        collectionView.reloadData()
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
        return allGroups().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.reuseIdentifier, for: indexPath) as? TopicCollectionViewCell
        else {
            fatalError()
        }
                
        cell.set(movieGroup: allGroups()[indexPath.row], moviesRepository: moviesRepository, topicCollectionViewCellDelegate: topicCollectionViewCellDelegate)
        
        return cell
    }
}


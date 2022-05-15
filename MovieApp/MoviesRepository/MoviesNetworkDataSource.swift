class MoviesNetworkDataSource{
    var networkService: NetworkService!
    var dataLoader: DataLoader!
    
    var delegate: MoviesNetworkDataSourceDelegate!
    
    init(){
        networkService = NetworkService()
        dataLoader = DataLoader()
    }
    
    func loadData(){
        dataLoader.loadData {
            self.delegate.storeLoadedGenres(genres: self.dataLoader.genres)
            
            for g in allGroups(){
                switch g {
                case .popular:
                    self.delegate.storeLoadedMovies(group: .popular, movies: self.dataLoader.popularMovies)
                case .trending:
                    self.delegate.storeLoadedMovies(group: .trending, movies: self.dataLoader.trendingMovies)
                case .topRated:
                    self.delegate.storeLoadedMovies(group: .topRated, movies: self.dataLoader.topRatedMovies)
                case .recommended:
                    self.delegate.storeLoadedMovies(group: .recommended, movies: self.dataLoader.recommendedMovies)
                }
            }
        }
    }
}

protocol MoviesNetworkDataSourceDelegate{
    func storeLoadedMovies(group: Group, movies: [MovieResult])
    func storeLoadedGenres(genres: [Genre])
}

import Foundation
// use case?
class DataLoader: DataLoaderProtocol{
    
    var popularMovies: [MovieResult]!
    var trendingMovies: [MovieResult]!
    var topRatedMovies: [MovieResult]!
    var recommendedMovies: [MovieResult]!
    
    public var genres: [Genre]!
    
    init() {
        popularMovies = []
        trendingMovies = []
        topRatedMovies = []
        recommendedMovies = []
        
        genres = []
        
    }
    
    func loadData(superGroup: DispatchGroup){
        let group = DispatchGroup()
        
        loadMovies(category: .popular, group: group)
        loadMovies(category: .trending, group: group)
        loadMovies(category: .topRated, group: group)
        loadMovies(category: .recommended, group: group)
        
        loadGenres(group: group)
        
        group.notify(queue: .main) {
            print("Finished loading movies and genres")
            superGroup.leave()
        }
    }
    
    func loadMovies(category: Category, group: DispatchGroup){
        group.enter()
        
        let urlStr = urlForCategory(category)
        
        guard let url = URL(string: urlStr) else { return }
        
        //        print("sending request to " + urlStr)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NetworkService().executeUrlRequest(request){ (result: Result<Page, RequestError>) in
            
            switch result {
            case .success(let value):
                switch category {
                case .popular:
                    self.popularMovies = value.results
                case .trending:
                    self.trendingMovies = value.results
                case .topRated:
                    self.topRatedMovies = value.results
                case .recommended:
                    self.recommendedMovies = value.results
                }
                
            case .failure(let error):
                RequestErrorHandle(error)
            }
            
            
            group.leave()
        }
    }
    
    func urlForCategory(_ c: Category) -> String{
        switch c {
        case .popular:
            return POPULAR_REQUEST_URL
        case .trending:
            return TRENDING_REQUEST_URL
        case .topRated:
            return TOPRATED_REQUEST_URL
        case .recommended:
            return RECOMMENDED_REQUEST_URL
        }
    }
    
    func loadGenres(group: DispatchGroup){
        let urlStr = GENRE_REQUEST_URL
        
        guard let url = URL(string: urlStr) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NetworkService().executeUrlRequest(request){ (result: Result<Genres, RequestError>) in
            
            switch result {
            case .success(let value):
                self.genres = value.genres
            case .failure(let error):
                RequestErrorHandle(error)
            }
            
            
        }
    }
    
    
}

protocol DataLoaderProtocol{
    var popularMovies: [MovieResult]! { get }
    var trendingMovies: [MovieResult]! { get }
    var topRatedMovies: [MovieResult]! { get }
    var recommendedMovies: [MovieResult]! { get }
    
    var genres: [Genre]! { get }
    
    func loadMovies(category: Category, group: DispatchGroup)
    func loadGenres(group: DispatchGroup)
    func loadData(superGroup: DispatchGroup)
}
import Foundation
import UIKit
// use case?
class DataLoader: DataLoaderProtocol{
    
    var popularMovies: [MovieResult]!
    var trendingMovies: [MovieResult]!
    var topRatedMovies: [MovieResult]!
    var recommendedMovies: [MovieResult]!
    
    var genres: [Genre]!
    var movieDetails: MovieDetails? = nil
    
    var moviePosterImages: [MoviePosterImage] = []
    var movieBackdropImages: [MovieBackdropImage] = []
    
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
    
    func loadMovieDetail(movieId: Int, group: DispatchGroup){
        let urlStr = getMovieDetailsUrl(movieId: String(movieId))
        
        guard let url = URL(string: urlStr) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NetworkService().executeUrlRequest(request){ (result: Result<MovieDetails, RequestError>) in
            
            switch result {
            case .success(let value):
                self.movieDetails = value
            case .failure(let error):
                RequestErrorHandle(error)
            }
            
            group.leave()
        }
    }
    
    func loadImage(urlStr: String, completionHandler: @escaping (UIImage) -> Void) {
        let url = URL(string: urlStr)
        guard let url=url else {
//            fatalError()
            print("Image failed to load")
            return
        }
        
        DispatchQueue.global().async { 
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            }
        }
    }
    
    func addMoviePosterImage(moviePosterImage: MoviePosterImage){
        if !(moviePosterImages.contains(moviePosterImage)){
            moviePosterImages.append(moviePosterImage)
        }
    }
    
    func addMovieBackdropImage(movieBackdropImage: MovieBackdropImage){
        if !(movieBackdropImages.contains(movieBackdropImage)){
            movieBackdropImages.append(movieBackdropImage)
        }
    }
    
}

protocol DataLoaderProtocol{
    var popularMovies: [MovieResult]! { get }
    var trendingMovies: [MovieResult]! { get }
    var topRatedMovies: [MovieResult]! { get }
    var recommendedMovies: [MovieResult]! { get }
    
    var genres: [Genre]! { get }
    
    var movieDetails: MovieDetails? { get }
    
    //  Stores images that were fetched so that we dont have to fetch them more than once
    var moviePosterImages: [MoviePosterImage] { get }
    var movieBackdropImages: [MovieBackdropImage] { get }
    
    func loadData(superGroup: DispatchGroup)
    func loadImage(urlStr: String, completionHandler: @escaping (UIImage) -> Void)
    func loadMovieDetail(movieId: Int, group: DispatchGroup)
    
    func addMoviePosterImage(moviePosterImage: MoviePosterImage)
    func addMovieBackdropImage(movieBackdropImage: MovieBackdropImage)
}

import UIKit

class MoviesRepository: MoviesNetworkDataSourceDelegate{
    var moviesDatabaseDataSource: MoviesDatabaseDataSource!
    var moviesNetworkDataSource: MoviesNetworkDataSource!
    
    var delegate: MoviesRepositoryDelegate!
    
    init(){
        moviesDatabaseDataSource = MoviesDatabaseDataSource()
        moviesNetworkDataSource = MoviesNetworkDataSource()
        
        moviesNetworkDataSource.delegate = self
        
//        moviesDatabaseDataSource.del()
        
        print("favs \(moviesDatabaseDataSource.fetchFavouriteMovies().count)")
        let genres = moviesDatabaseDataSource.fetchMovies()[2].value(forKey: "genre_ids") as? NSArray
        let arr = genres as? [Int16]
        print(arr)
    }
    
//    Normal:       Fetch data from the internet, refresh database and show the data
//    No Internet:  Load data from database and show it
    func fetchData(completionHandler: @escaping () -> Void){
        let group = DispatchGroup()
        moviesNetworkDataSource.loadData(group: group)
        
        group.notify(queue: .main) {
            completionHandler()
        }
    }
    
    
    func getLoadedMovies(group: Group, genreId: Int) -> [MovieViewModel]{
        let movies = moviesDatabaseDataSource.fetchMovies(group: group, genreId: genreId)
        print("getting movies, count: \(movies.count)")
        return movies.map{ MovieViewModel(movie: $0) }
    }
    
    func getLoadedMovies() -> [MovieViewModel]{
        let movies = moviesDatabaseDataSource.fetchMovies()
        print("getting all movies, count: \(movies.count)")
        return movies.map{ MovieViewModel(movie: $0) }
    }
    
    func getLoadedMovies(withText: String) -> [MovieViewModel]{
        let movies = moviesDatabaseDataSource.fetchMovies(withText: withText)
        print("getting filtered movies, count: \(movies.count)")
        return movies.map{ MovieViewModel(movie: $0) }
    }
    
    
    func getFavouriteMovies() -> [MovieViewModel]{
        let movies = moviesDatabaseDataSource.fetchFavouriteMovies()
        print("getting \(movies.count) favourites")
        return movies.map{ MovieViewModel(movie: $0) }
    }
    
    func getMovie(id: Int) -> MovieViewModel?{
        print("get movie")
        guard let movie = moviesDatabaseDataSource.fetchMovie(id: id) else{
            return nil
        }
        
        return MovieViewModel(movie: movie)
    }
    
    func getLoadedGenres() -> [MovieGenreViewModel]{
        let genres = moviesDatabaseDataSource.fetchGenres()
        
        return genres.map{ MovieGenreViewModel(movieGenre: $0) }
    }
    
    
    
    
    func storeLoadedMovies(group: Group, movies: [MovieResult]){
        print("storing loaded movies \(movies.count)")
        moviesDatabaseDataSource.addMovies(group: group, movieResults: movies)
        
        delegate.reloadData()
    }
    
    func storeLoadedGenres(genres: [Genre]){
        print("storing loaded genres")
        moviesDatabaseDataSource.addGenres(genres: genres)
        
        delegate.reloadData()
    }
    
    func toggleFavourite(movieId: Int){
        moviesDatabaseDataSource.toggleFavourite(id: movieId)
        
        delegate.reloadData()
    }
    
    func getMovieDetails(movieId: Int, completionHandler: @escaping (MovieDetails) -> Void){
        moviesNetworkDataSource.loadMovieDetails(movieId: movieId, completionHandler: completionHandler)
    }
    
    func loadImage(urlStr: String, completionHandler: @escaping (UIImage) -> Void){
        moviesNetworkDataSource.loadImage(urlStr: urlStr, completionHandler: completionHandler)
    }
}

protocol MoviesRepositoryDelegate{
    func reloadData()
}

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
        fetchData()
    }
    
//    Normal:       Fetch data from the internet, refresh database and show the data
//    No Internet:  Load data from database and show it
    func fetchData(){
        moviesNetworkDataSource.loadData()
    }
    
    
    func getLoadedMovies(group: Group) -> [MovieViewModel]{
        let movies = moviesDatabaseDataSource.fetchMovies(group: group)
        
        return movies.map{ MovieViewModel(movie: $0) }
    }
    
    func getLoadedGenres() -> [MovieGenreViewModel]{
        let genres = moviesDatabaseDataSource.fetchGenres()
        
        return genres.map{ MovieGenreViewModel(movieGenre: $0) }
    }
    
    
    func storeLoadedMovies(group: Group, movies: [MovieResult]){
        print("storing loaded movies")
        moviesDatabaseDataSource.addMovies(group: group, movieResults: movies)
        
//        delegate.reloadData()
    }
    
    func storeLoadedGenres(genres: [Genre]){
        print("storing loaded genres")
        moviesDatabaseDataSource.addGenres(genres: genres)
        
//        delegate.reloadData()
    }
}

protocol MoviesRepositoryDelegate{
    func reloadData()
}

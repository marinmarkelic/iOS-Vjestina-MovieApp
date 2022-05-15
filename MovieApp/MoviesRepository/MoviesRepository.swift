import UIKit

class MoviesRepository: MoviesNetworkDataSourceDelegate{
    var moviesDatabaseDataSource: MoviesDatabaseDataSource!
    var moviesNetworkDataSource: MoviesNetworkDataSource!
    
    init(){
        moviesDatabaseDataSource = MoviesDatabaseDataSource()
        moviesNetworkDataSource = MoviesNetworkDataSource()
        
        moviesNetworkDataSource.delegate = self
        
        moviesDatabaseDataSource.del()
        fetchData()
    }
    
//    Normal:       Fetch data from the internet, refresh database and show the data
//    No Internet:  Load data from database and show it
    func fetchData(){
        moviesNetworkDataSource.loadData()
    }
    
    
    func getLoadedMovies(group: Group){
        let movies = moviesDatabaseDataSource.fetchMovies(group: group)
        
        print("movies:")
        print(movies.count)
    }
    
    
    func storeLoadedMovies(group: Group, movies: [MovieResult]){
        print("storing loaded movies")
        moviesDatabaseDataSource.addMovies(group: group, movieResults: movies)
        
        getLoadedMovies(group: group)
    }
    
    func storeLoadedGenres(genres: [Genre]){
        print("storing loaded genres")
        moviesDatabaseDataSource.addGenres(genres: genres)
    }
}

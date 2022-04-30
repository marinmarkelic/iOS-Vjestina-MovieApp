import Foundation

enum MovieCategory{
    case popular
    case trending
    case topRated
    case recommended
}

func URLForMovieCategory(_ c: MovieCategory) -> URL?{
    var url = ""
    
    switch c {
    case .popular:
        url = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=Capi_key=b6430e3b7d34547084b0acc97fe5b8a5"
    case .trending:
        url = "https://api.themoviedb.org/3/trending/movie/week?api_key=b6430e3b7d34547084b0acc97fe5b8a5"
    case .topRated:
        url = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=Capi_key=b6430e3b7d34547084b0acc97fe5b8a5"
    case .recommended:
        url = "https://api.themoviedb.org/3/movie/103/recommendations?language=en-US&page=1&api_key=Capi_key=b6430e3b7d34547084b0acc97fe5b8a5"
    }
    
    guard let url = URL(string: url) else {return nil}
    
    return url
}

func URLForGenres() -> URL?{
    let url = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=b6430e3b7d34547084b0acc97fe5b8a5"
    
    guard let url = URL(string: url) else {return nil}
    
    return url
}

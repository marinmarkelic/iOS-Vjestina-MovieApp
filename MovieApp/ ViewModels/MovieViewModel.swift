import Foundation
struct MovieViewModel{
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Float
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int
    let isFavourite: Bool
    
    init(movie: Movie){
        self.adult = movie.adult
        self.backdrop_path = movie.backdrop_path ?? ""
        if let values=movie.value(forKey: "genre_ids") as? NSArray,
           let valuesArr=values as? [Int16]{
            self.genre_ids = valuesArr.map{ Int($0) }
        }
        else{
            self.genre_ids = []
        }
        self.id = Int(movie.id)
        self.original_language = movie.original_language ?? ""
        self.original_title = movie.original_title ?? ""
        self.overview = movie.overview ?? ""
        self.popularity = movie.popularity
        self.poster_path = movie.poster_path ?? ""
        self.release_date = movie.release_date ?? ""
        self.title = movie.title ?? ""
        self.video = movie.video
        self.vote_average = movie.vote_average
        self.vote_count = Int(movie.vote_count)
        self.isFavourite = false
    }
}

struct MovieViewModel{
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int16]?
    let id: Int32
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Float
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool
    let vote_average: Float
    let vote_count: Int32
    let isFavourite: Bool
    
    init(movie: Movie){
        self.adult = movie.adult
        self.backdrop_path = movie.backdrop_path
        self.genre_ids = movie.genre_ids
        self.id = movie.id
        self.original_language = movie.original_language
        self.original_title = movie.original_title
        self.overview = movie.overview
        self.popularity = movie.popularity
        self.poster_path = movie.poster_path
        self.release_date = movie.release_date
        self.title = movie.title
        self.video = movie.video
        self.vote_average = movie.vote_average
        self.vote_count = movie.vote_count
        self.isFavourite = false
    }
}

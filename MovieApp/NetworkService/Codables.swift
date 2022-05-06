struct Page: Codable{
    let results: [MovieResult]
}

struct MovieResult: Codable{
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let genre_ids: [Int]
}

struct MovieDetails: Codable{
    let original_title: String
    let id: Int
    let overview: String
    let backdrop_path: String
    let release_date: String
    let production_countries: [ProductionCountry]
    let genres: [Genre]
    let popularity: Float
    let runtime: Int
}

struct ProductionCountry: Codable{
    let iso_3166_1: String    
}

struct Genres: Codable{
    let genres: [Genre]
}

struct Genre: Codable{
    let id: Int
    let name: String
}

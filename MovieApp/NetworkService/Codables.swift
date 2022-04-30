struct Page: Codable{
    let results: [MovieResult]
}

struct MovieResult: Codable{
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String
    let release_date: String
}

struct Genres: Codable{
    let genres: [Genre]
}

struct Genre: Codable{
    let id: Int
    let name: String
}

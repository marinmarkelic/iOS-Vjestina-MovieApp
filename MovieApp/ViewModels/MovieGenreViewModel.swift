struct MovieGenreViewModel{
    let name: String?
    let id: Int
    
    init(movieGenre: MovieGenre) {
        self.name = movieGenre.name
        self.id = Int(movieGenre.id)
    }
}

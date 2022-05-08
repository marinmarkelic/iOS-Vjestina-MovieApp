import UIKit

struct MoviePosterImage: Equatable{
    let id: Int
    let image: UIImage?
    
    static func == (lhs: MoviePosterImage, rhs: MoviePosterImage) -> Bool{
        return lhs.id == rhs.id
    }
}

struct MovieBackdropImage: Equatable{
    let id: Int
    let image: UIImage?
    
    static func == (lhs: MovieBackdropImage, rhs: MovieBackdropImage) -> Bool{
        return lhs.id == rhs.id
    }
}

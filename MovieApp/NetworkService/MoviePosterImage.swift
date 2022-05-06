import UIKit

struct MoviePosterImage: Equatable{
    let id: Int
    let image: UIImage?
    
    static func == (lhs: MoviePosterImage, rhs: MoviePosterImage) -> Bool{
        return lhs.id == rhs.id
    }
}

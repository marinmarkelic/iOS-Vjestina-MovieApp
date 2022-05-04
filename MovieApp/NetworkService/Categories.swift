enum Category{
    case popular
    case trending
    case topRated
    case recommended
}

func allCategories() -> [Category] {
    [.popular, .trending, .topRated, .recommended]
}

func categoryToString(_ category: Category) -> String {
    switch category {
    case .popular:
        return "Popular"
    case .trending:
        return "Trending"
    case .topRated:
        return "Top Rated"
    case .recommended:
        return "Recommended"
    default:
        return "N/A"
    }
}

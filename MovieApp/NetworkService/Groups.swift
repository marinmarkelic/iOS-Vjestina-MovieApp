enum Group{
    case popular
    case trending
    case topRated
    case recommended
}

func allGroups() -> [Group] {
    [.popular, .trending, .topRated, .recommended]
}

func groupToString(_ group: Group) -> String {
    switch group {
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

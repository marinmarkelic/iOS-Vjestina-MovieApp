import CoreData

class MoviesDatabaseDataSource{
    var coreDataStack: CoreDataStack!
    var managedContext: NSManagedObjectContext!
    
    init(){
        coreDataStack = CoreDataStack()
        managedContext = coreDataStack.persistentContainer.viewContext
        
        addMovieGroups()
    }
    
    
    
    func addMovies(group: Group, movieResults: [MovieResult]){
        
        print("adding \(movieResults.count) movies to \(groupToString(group))")
        let movieGroup = groupToMovieGroup(group: group)
        
        for m in movieResults{
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
            let movie = Movie(entity: entity, insertInto: managedContext)
            
            movie.adult = m.adult
            movie.backdrop_path = m.backdrop_path
            movie.genre_ids = m.genre_ids.map({ Int32($0) })
            movie.id = Int32(m.id)
            movie.original_language = m.original_language
            movie.original_title = m.original_title
            movie.overview = m.overview
            movie.popularity = m.popularity
            movie.poster_path = m.poster_path
            movie.release_date = m.release_date
            movie.title = m.title
            movie.video = m.video
            movie.vote_average = m.vote_average
            movie.vote_count = Int32(m.vote_count)
            movie.isFavourite = false
            
            
            movieGroup.addToMovies(movie)
        }
        
        try? managedContext.save()
    }
    
    func fetchMovies(group: Group) -> [Movie]{
        print("fetching movies for \(groupToString(group))")
//        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
//
//        let entity = NSEntityDescription.entity(forEntityName: "MovieGroup", in: managedContext)!
//        let movieGroup = MovieGroup(entity: entity, insertInto: managedContext)
//        movieGroup.name = groupToString(group)
//
//        let predicate = NSPredicate(format: "%@ IN groups", "\(movieGroup)")
        
        let fetchRequest = MovieGroup.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", "\(groupToString(group))")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do{
            let group = try managedContext.fetch(fetchRequest).first //should be length 1
            
            guard let group=group else{
                return []
            }
            
            guard let set=group.value(forKey: "movies") as? NSSet else{
                return []
            }
            
            guard let movies=set.allObjects as? [Movie] else{
                return []
            }
            return movies
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return []
        }
    }
    
    
    
    func addGenres(genres: [Genre]){
//        let fetchRequest = MovieGenre.fetchRequest()
        
        for g in genres{
            let entity = NSEntityDescription.entity(forEntityName: "MovieGenre", in: managedContext)!
            let movieGenre = MovieGenre(entity: entity, insertInto: managedContext)
            
            movieGenre.name = g.name
            movieGenre.id = Int16(g.id)
            
//            for e in allGroups(){
//                let movies = fetchMovies(group: e)
//
//                for m in movies{
//                    guard let mGenres=m.genres else{
//                        continue
//                    }
//                    if(mGenres.allObjects.contains(where: { $0 as? Int32 == Int32(g.id) })){
//                        print("adding genre ------")
//                        m.addToGenres(movieGenre)
//                    }
//                }
//            }
        }
        
        try? managedContext.save()
    }
    
    
    
    func addMovieGroups(){
        let fetchRequest = MovieGroup.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        // If movie groups are already saved return.
        guard let count = try? managedContext.count(for: fetchRequest),
              count == 0
        else{
            return
        }
        
        
        for g in allGroups(){
            let entity = NSEntityDescription.entity(forEntityName: "MovieGroup", in: managedContext)!
            let movieGroup = MovieGroup(entity: entity, insertInto: managedContext)
            
            movieGroup.name = groupToString(g)
        }
        
        try? managedContext.save()
    }
    
    func fetchMovieGroups() -> [MovieGroup]{
        let fetchRequest = MovieGroup.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            return try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return []
        }
    }
    
    func groupToMovieGroup(group: Group) -> MovieGroup{
        let entity = NSEntityDescription.entity(forEntityName: "MovieGroup", in: managedContext)!
        let movieGroup = MovieGroup(entity: entity, insertInto: managedContext)
        
        movieGroup.name = groupToString(group)
        
        return movieGroup
    }
    
    func del(){
        managedContext.reset()
        
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Movie")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch _ as NSError {
            // TODO: handle the error
        }

        fetchRequest = NSFetchRequest(entityName: "MovieGroup")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch _ as NSError {
            // TODO: handle the error
        }

        fetchRequest = NSFetchRequest(entityName: "MovieGenre")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch _ as NSError {
            // TODO: handle the error
        }

        try? managedContext.save()
    }
}

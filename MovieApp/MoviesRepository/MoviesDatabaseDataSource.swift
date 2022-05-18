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
        let movieGroupName = groupToString(group)
//        guard let movieGroup = fetchMovieGroup(name: movieGroupName) else{
//            print("Movie group doesnt exist")
//            return
//        }
        let movieGroup = groupToMovieGroup(group: group)
        
        for m in movieResults{
            
//            Edits the existing movie info if it is already saved
            var movie: Movie
            if fetchMovie(id: m.id) == nil{
                let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
                movie = Movie(entity: entity, insertInto: managedContext)
                movie.favourite = false
            }
            else{
                movie = fetchMovie(id: m.id)!
            }
            
            movie.adult = m.adult
            movie.backdrop_path = m.backdrop_path
            movie.genre_ids = m.genre_ids.map({ Int16($0) })
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
            
                        
            movieGroup.addToMovies(movie)
            movie.addToGroups(movieGroup)
        }
        
        try? managedContext.save()
    }
    
    func fetchMovie(id: Int) -> Movie?{
        let fetchRequest = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(Int32(id))")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do{
            return try managedContext.fetch(fetchRequest).first
        }catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return nil
        }
    }
    
    func fetchMovies() -> [Movie]{
        let fetchRequest = Movie.fetchRequest()
        let fullNameSort = NSSortDescriptor(key: "original_title", ascending: true)
        
        fetchRequest.sortDescriptors = [fullNameSort]
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            return try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
        }
        
        return []
    }
    
    func fetchMovies(withText: String) -> [Movie]{
        let fetchRequest = Movie.fetchRequest()
        let predicate = NSPredicate(format: "original_title CONTAINS[c] %@", "\(withText)")
        let fullNameSort = NSSortDescriptor(key: "original_title", ascending: true)
        
        fetchRequest.sortDescriptors = [fullNameSort]
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        
        do{
            return try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
        }
        
        return []
    }
    
//    fix, have to predicate by moviegroup
    func fetchMovies(group: Group, genreId: Int) -> [Movie]{
        print("fetching movies for \(groupToString(group))")
        try? managedContext.fetch(Movie.fetchRequest()).forEach{
            print("Genres for \($0.original_title!): \($0.genre_ids!)")
        }

        let fetchRequest = Movie.fetchRequest()
//        let predicate = NSPredicate(format: "%@ in self.groups.name", "\(groupToString(group))")
//        let predicate = NSPredicate(format: "ANY groups.name = %@", "\(groupToString(group))")

//        let predicate = NSPredicate(format: "%@ IN self.genre_ids", "\(NSNumber(28))")
        let predicate = NSPredicate(format: "ANY genre_ids = nil", "\(NSNumber(28))")



//        let fullNameSort = NSSortDescriptor(key: "original_title", ascending: true)
//
//        fetchRequest.sortDescriptors = [fullNameSort]
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate

        do{
            let a = try managedContext.fetch(fetchRequest)
            a.forEach({
                print($0.genre_ids)
            })
            print("\(a.count) results for \(groupToString(group))")
            return a
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
        }

        return []
        
//        let fetchRequest = MovieGroup.fetchRequest()
//        let predicate = NSPredicate(format: "name == %@", "\(groupToString(group))")
//
//        fetchRequest.returnsObjectsAsFaults = false
//        fetchRequest.predicate = predicate
//        fetchRequest.fetchLimit = 1
//
//        do{
//            let group = try managedContext.fetch(fetchRequest).first
//            guard let group=group,
//                  let set=group.value(forKey: "movies") as? NSSet,
//                  let movies=set.allObjects as? [Movie] else{
//                      return []
//                  }
//
//            return movies.filter({
//               print("\(genreId) \($0.genre_ids) \($0.genre_ids!.contains(Int16(genreId)))")
//                return $0.genre_ids!.contains(Int16(genreId))
//
//            })
//        }
//        catch let error as NSError{
//            print("Error \(error), Info: \(error.userInfo)")
//        }
//
//        return []
    }
    
    func fetchFavouriteMovies() -> [Movie]{
        let fetchRequest = Movie.fetchRequest()
        let predicate = NSPredicate(format: "favourite = YES", "")
        let fullNameSort = NSSortDescriptor(key: "original_title", ascending: true)
        
        fetchRequest.sortDescriptors = [fullNameSort]
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        
        do{
            return try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
        }
        
        return []
    }
    
    func toggleFavourite(id: Int){        
        guard let movie = fetchMovie(id: id) else{
            print("Failed to toggle favourite, movie doesnt exist")
            return
        }
        
        movie.favourite = !movie.favourite
        print("toggle \(movie.favourite)")
        try? managedContext.save()
    }
    
    
    
    func addGenres(genres: [Genre]){
        for g in genres{
            
//            Edits the existing movie info if it is already saved
            var movieGenre: MovieGenre
            if fetchMovieGenre(id: g.id) == nil{
                let entity = NSEntityDescription.entity(forEntityName: "MovieGenre", in: managedContext)!
                movieGenre = MovieGenre(entity: entity, insertInto: managedContext)
            }
            else{
                movieGenre = fetchMovieGenre(id: g.id)!
            }
            
            movieGenre.name = g.name
            movieGenre.id = Int16(g.id)
            
            for m in fetchMovies(){
                guard let nsArray=m.value(forKey: "genre_ids") as? NSArray,
                      let genresArray=nsArray as? [Int16]
                else{
                    print("cont")
                    continue
                }
                
                if(genresArray.contains(Int16(g.id))){
                    m.addToGenres(movieGenre)
                    movieGenre.addToMovies(m)
                }
            }
//            for e in allGroups(){
//                let movies = fetchMovies(group: e, genreId: g.id)
//                for m in movies{
//                    guard let nsArray=m.value(forKey: "genre_ids") as? NSArray,
//                          let genresArray=nsArray as? [Int16]
//                           else{
//                               print("cont")
//                        continue
//                    }
//
//                    if(genresArray.contains(Int16(g.id))){
//                        m.addToGenres(movieGenre)
//                        movieGenre.addToMovies(m)
//                    }
//                }
//            }
        }
        
        try? managedContext.save()
    }
    
    func fetchMovieGenre(id: Int) -> MovieGenre?{
        let fetchRequest = MovieGenre.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(Int16(id))")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do{
            return try managedContext.fetch(fetchRequest).first
        }catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return nil
        }
    }
    
    func fetchGenres() -> [MovieGenre]{
        let fetchRequest = MovieGenre.fetchRequest()
        let fullNameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [fullNameSort]
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            return try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
        }
        
        return []
    }
    
    
    
    func addMovieGroups(){
        let fetchRequest = MovieGroup.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        // If movie groups are already saved return.
        guard let count = try? managedContext.count(for: fetchRequest),
              count == 0
        else{
            print("---not adding more groups")
            return
        }
        
        print("---Adding more groups")
        
        for g in allGroups(){
            var movieGenre: MovieGroup
            if fetchMovieGroup(name: groupToString(g)) == nil{
                let entity = NSEntityDescription.entity(forEntityName: "MovieGroup", in: managedContext)!
                movieGenre = MovieGroup(entity: entity, insertInto: managedContext)
            }
            else{
                movieGenre = fetchMovieGroup(name: groupToString(g))!
            }
            
            movieGenre.name = groupToString(g)
        }
        
        try? managedContext.save()
    }
    
    func fetchMovieGroup(name: String) -> MovieGroup?{
        let fetchRequest = MovieGroup.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", "\(name)")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do{
            return try managedContext.fetch(fetchRequest).first
        }catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
            return nil
        }
    }
    
    func fetchMovieGroups() -> [MovieGroup]{
        let fetchRequest = MovieGroup.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            return try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Error \(error), Info: \(error.userInfo)")
        }
        
        return []
    }
    
    func groupToMovieGroup(group: Group) -> MovieGroup{
        var movieGroup: MovieGroup
        if fetchMovieGroup(name: groupToString(group)) == nil{
            let entity = NSEntityDescription.entity(forEntityName: "MovieGroup", in: managedContext)!
            movieGroup = MovieGroup(entity: entity, insertInto: managedContext)
            movieGroup.name = groupToString(group)
        }
        else{
            movieGroup = fetchMovieGroup(name: groupToString(group))!
        }
        
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

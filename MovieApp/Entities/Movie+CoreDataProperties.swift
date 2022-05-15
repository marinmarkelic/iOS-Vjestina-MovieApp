//
//  Movie+CoreDataProperties.swift
//  MovieApp
//
//  Created by Marin on 15.05.2022..
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var genre_ids: [Int16]?
    @NSManaged public var id: Int32
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Float
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Float
    @NSManaged public var vote_count: Int32
    @NSManaged public var isFavourite: Bool
    @NSManaged public var groups: NSSet?
    @NSManaged public var genres: NSSet?

}

// MARK: Generated accessors for groups
extension Movie {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: MovieGroup)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: MovieGroup)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}

// MARK: Generated accessors for genres
extension Movie {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: MovieGenre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: MovieGenre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

extension Movie : Identifiable {

}

//
//  Movies + CoreData.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData


struct MoviesCoredataModel {
    var id: Int64
    var imageURL: String
    var title: String
    var isFavorite: Bool
    
    init(movie: Movie) {
        self.id = Int64(movie.id ?? 0)
        self.imageURL = movie.imageURL
        self.title = movie.title ?? ""
        self.isFavorite = false
    }
    
}

func == (lhs: MoviesCoredataModel, rhs: MoviesCoredataModel) -> Bool {
    return lhs.id == rhs.id
}

extension MoviesCoredataModel : Equatable { }

extension MoviesCoredataModel : IdentifiableType {
    typealias Identity = String
    
    var identity: Identity { return "\(id)" }
}

extension MoviesCoredataModel : Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "MovieList"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        id = entity.value(forKey: "id") as! Int64
        imageURL = entity.value(forKey: "imageURL") as! String
        title = entity.value(forKey: "title") as! String
        isFavorite = entity.value(forKey: "isFavorite") as! Bool
        
    }
    
    func update(_ entity: T) {
        entity.setValue(id, forKey: "id")
        entity.setValue(imageURL, forKey: "imageURL")
        entity.setValue(title, forKey: "title")
        entity.setValue(isFavorite, forKey: "isFavorite")
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}

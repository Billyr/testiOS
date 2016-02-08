//
//  Libro+CoreDataProperties.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 07/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Libro {

    @NSManaged var isbn: String!
    @NSManaged var portada: NSData?
    @NSManaged var titulo: String!
    @NSManaged var autores: NSSet

}

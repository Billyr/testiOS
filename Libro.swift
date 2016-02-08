//
//  Libro.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 07/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Libro)
class Libro: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    
    func setDatos(json:JSON, isbn:String, context:NSManagedObjectContext!) {
        
        let clave = "ISBN:\(isbn)"
        
        self.isbn = isbn
        self.titulo = json[ clave ]["title"].stringValue
        
        if let portada = json[ clave ]["cover"].dictionary {
            
            let url = NSURL( string: (portada["medium"]?.stringValue)! )
            let data = NSData(contentsOfURL: url!)
            let imagen = UIImage(data: data!)
            
            self.portada = UIImageJPEGRepresentation(imagen!, 1.0)
        }
        
        
        //var lista = Set<NSObject>()
        for autores in json[ clave ]["authors"].arrayValue {
            
            let autor = NSEntityDescription.insertNewObjectForEntityForName("Autor", inManagedObjectContext: context) as! Autor
            
            autor.nombre = autores["name"].string
            
            let lista = self.mutableSetValueForKey("autores")
            lista.addObject(autor)
            
            //self.autores.setValue(autor, forKey: "autores") // Nombre de la relacion
            //self.autores.setValue(autor, forKey: "Autor")

            //lista.insert(autor)
        }
        //self.setValue(lista, forKey: "autores")
    }
}

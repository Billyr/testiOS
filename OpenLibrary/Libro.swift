//
//  Libro.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 03/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import Foundation

class Libro {
    
    var isbn:String!
    var titulo:String!
    var autores=[String]()
    var portada:String?
    
    
    init(json:JSON, isbn:String) {
        
        let clave = "ISBN:\(isbn)"
        
        self.isbn = isbn
        self.titulo = json[ clave ]["title"].stringValue
        
        for item in json[ clave ]["authors"].arrayValue {
            
            self.autores.append(item["name"].stringValue)
        }
        
        
        if let portada = json[ clave ]["cover"].dictionary {
            self.portada = portada["medium"]!.string
        }
        
    }
    
    
}
//
//  Metodo.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 13/01/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import Foundation

func asincrono() {
    let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7"
    let url = NSURL(string: urls)
    let sesion = NSURLSession.sharedSession()
    let bloque = { (datos:NSData?, resp:NSURLResponse?, error:NSError?) -> Void in
        
        let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        print(texto!)
        //resultadoJSON.text = "Saludos!!!"
        
    }
    
    let dt = sesion.dataTaskWithURL(url!, completionHandler: bloque)
    dt.resume()
}


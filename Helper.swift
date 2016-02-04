//
//  Helper.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 03/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import Foundation

var libros = [Libro]()

func main_queue( callback: () -> () ) {
        dispatch_async(dispatch_get_main_queue(), callback)
}
    
//
//  Datos.swift
//  Hamburguesas
//
//  Created by Billy Rangel on 13/01/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import Foundation

public class Paises {
    
    let paises = ["México", "U.S.A", "Canada", "Argentina", "Brasil",
                  "Colombia", "Paraguay", "España", "Francia", "Italia",
                  "Alemania", "Portugal", "Suiza", "India", "Kazajistan",
                  "Egipto", "Marruecos", "Japón", "Korea", "China"]
    
    
    func obtenerPais() -> String {
        
        return paises[ Int( arc4random() ) % paises.count]
        
    }
    
}

public class Hamburguesas {
    
    let hamburguesas = ["Mc Artana", "Mc Connections", "Mc Treze", "Antonio Megias", "Mc Glutenfree",
                  "Mc Perla", "BBQ Bacon", "Mister Crunch", "Suspiro", "French Chicken",
                  "Serranito", "La Grandiosa", "Special Chick", "Mc Poliyoli", "Mc Frufi",
                  "Italian Chicken Delice", "Chicken BBQ", "Mc Nifica", "Chicken Healthy with Tomatoes", "Mc Tosta"]
    
    
    func obtenerHamburguesa() -> String {
        
        return hamburguesas[ Int( arc4random() ) % hamburguesas.count ]
        
    }
    
}
//
//  ViewController.swift
//  Hamburguesas
//
//  Created by Billy Rangel on 13/01/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var boton: UIButton!
    @IBOutlet weak var pais: UILabel!
    @IBOutlet weak var hamburguesa: UILabel!
    

    
    @IBAction func mostrar(sender: AnyObject) {
        
        let pais = Paises()
        let ham = Hamburguesas()
        
        
        self.pais.text = ( "Pais: \(pais.obtenerPais())" )
        self.hamburguesa.text = ham.obtenerHamburguesa()
        
    }
}

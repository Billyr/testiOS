//
//  DetallesViewController.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 02/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit

class DetallesViewController: UIViewController {
    
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    var libro : Libro!
    
    override func viewDidLoad() {
        
        self.titulo.text = ""
        self.autores.text = ""
        
    
        // Titutlo
       self.titulo.text = libro.titulo
        
        // Autores
        var buffer = ""
        
        for autor in libro.autores {
            
            buffer.appendContentsOf( String(format: "%@\n", autor.valueForKey!("nombre") as! String) )
            
        }
        
        self.autores.text = buffer
        

        // Imagen de portada
        if libro.portada != nil {
            self.portada.image = UIImage(data: libro.portada!)
        }

    }

    @IBAction func irPrincipal(sender: AnyObject) {

        self.navigationController!.popToRootViewControllerAnimated(true)
        
    }

}

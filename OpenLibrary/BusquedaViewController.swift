//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 13/01/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit


class BusquedaViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cajaBusqueda: UITextField!
    
    
    override func viewDidLoad() {
        
        self.cajaBusqueda.delegate = self
        self.cajaBusqueda.clearButtonMode = .Always
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        if textField.text != "" {
            Busqueda()
            return true
        } else {
            self.alerta("Ingrese el ISBN a buscar")
            return false
        }
    }
    
    
    private func Busqueda() {
        
        var api = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        api.appendContentsOf(cajaBusqueda.text!)

        let url = NSURL(string: api)
        let sesion = NSURLSession.sharedSession()
        
        let callback = { (datos:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if response != nil {
                
                let json = JSON(data: datos!)
                
                let id = "ISBN:\(self.cajaBusqueda.text!)"
                
                if let elementos = json[ id ].dictionary?.count where elementos > 0 {
                    let libro = Libro(json: json,isbn: self.cajaBusqueda.text!)
                    libros.append(libro)
                } else {
                    self.alerta("El libro no se encontró")
                    return
                }
                
                main_queue {
                    
                    let detallesController = self.storyboard?.instantiateViewControllerWithIdentifier("detalles") as! DetallesViewController
                    detallesController.libro = libros[libros.count - 1]
                    self.navigationController?.pushViewController(detallesController, animated: true)
                }
                
            
            } else {
                self.alerta("ERROR: Falla con Internet")
                return
            }
            
        } // Callback
        
        let tarea = sesion.dataTaskWithURL(url!, completionHandler: callback)
        tarea.resume()
        

    }
    
    func alerta(msg:String) {
        let alerta = UIAlertController(title: "OpenLibrary", message: msg, preferredStyle: .Alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: nil))
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    
} // End Clase













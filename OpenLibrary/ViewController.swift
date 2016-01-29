//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 13/01/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textoBusqueda: UITextField!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    
    override func viewDidLoad() {
        
        self.textoBusqueda.delegate = self
        
        self.titulo.text = ""
        self.autores.text = ""
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == textoBusqueda {
            
            textField.resignFirstResponder()
            
            
            if self.textoBusqueda.text == "" {
                self.alerta("Falta ingresar el ISBN del libro")
                return false
            } else {
                self.titulo.text = ""
                self.autores.text = ""
                self.portada.image = nil
                Buscar()
            }
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


    func Buscar() {
        
        var urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        urls.appendContentsOf(textoBusqueda.text!)
        
        let url = NSURL(string: urls)
        let sesion = NSURLSession.sharedSession()
        
        let callback = { (datos:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if response != nil {
                
                dispatch_async(dispatch_get_main_queue(), {
                    //let json = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                    
                    do {
                        
                        let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                        let clave = "ISBN:" + self.textoBusqueda.text!
                        
                        if let info = json[clave] as? NSDictionary {
                            
                            // Titutlo
                            if let titulo = info["title"] as? String {
                                self.titulo.text = titulo
                            }
                            
                            
                            // Autores
                            if let autoresLista = info["authors"] as? NSArray {
                                var buffer = ""
                                
                                for autor in autoresLista {
                                    buffer.appendContentsOf( String(format: "%@\n", (autor["name"] as? String)! ) )
                                }
                                self.autores.text = buffer
                            }
                            
                            
                            // Imagen de portada
                            if let imagen = info["cover"] as? NSDictionary {
                                let url = NSURL( string: imagen["medium"] as! String )
                                let data = NSData(contentsOfURL: url!)
                                self.portada.image = UIImage(data: data!)
                            }
                            
                            
                        }
                        
                        
                    }
                    catch _ {
                    }
                    
                })
            } else {
                self.alerta("ERROR: Falla con Internet")
            }
            
        }
        
        
        let dt = sesion.dataTaskWithURL(url!, completionHandler: callback)
        dt.resume()
    }
    
    
    
    
    func alerta(msg:String) {
        let alerta = UIAlertController(title: "OpenLibrary", message: msg, preferredStyle: .Alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: nil))
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    
        
} // End Clase













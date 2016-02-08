//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 13/01/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit
import CoreData

class BusquedaViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var cajaBusqueda: UITextField!
    var context : NSManagedObjectContext!
    
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
        
        let busqueda = NSFetchRequest(entityName: "Libro")
        let filtro = NSPredicate(format: "isbn == %@", cajaBusqueda.text! )
        busqueda.predicate = filtro
        
        do {

            if let resultado = try context.executeFetchRequest(busqueda) as? [Libro] {
            
                if resultado.count > 0 {
                    
                    mostrarDetalles(resultado[0])
                    
                } else {
                    
                    var api = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
                    api.appendContentsOf(cajaBusqueda.text!)
                    
                    let url = NSURL(string: api)
                    let sesion = NSURLSession.sharedSession()
                    
                    let callback = { (datos:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                        
                        if response != nil {
                            
                            let json = JSON(data: datos!)
                            
                            let id = "ISBN:\(self.cajaBusqueda.text!)"
                            
                            if let elementos = json[ id ].dictionary?.count where elementos > 0 {
                                
                                let libro = NSEntityDescription.insertNewObjectForEntityForName("Libro", inManagedObjectContext: self.context) as! Libro
                                
                                libro.setDatos(json, isbn: self.cajaBusqueda.text!,context: self.context)
                                
                                do {
                                    try self.context.save()
                                } catch {
                                    print("\(error)")
                                    return
                                }
                                
                                libros.append(libro)
                                
                                self.mostrarDetalles(libro)
                                
                            } else {
                                self.alerta("El libro no se encontró")
                                return
                            }
                        } else {
                            self.alerta("ERROR: Falla con Internet")
                            return
                        }
                    } // Callback
                    
                    let tarea = sesion.dataTaskWithURL(url!, completionHandler: callback)
                    tarea.resume()
                }
            }
        } catch {
            print("ERROR: \(error)")
            return
        }
        
    } // Busqueda
    
    
    private func mostrarDetalles(libro:Libro) {
        
        main_queue {
            
            let detallesController = self.storyboard?.instantiateViewControllerWithIdentifier("detalles") as! DetallesViewController
            detallesController.libro = libro
            self.navigationController?.pushViewController(detallesController, animated: true)
        }
        
    }
    
    
    func alerta(msg:String) {
        let alerta = UIAlertController(title: "OpenLibrary", message: msg, preferredStyle: .Alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: nil))
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    
} // End Clase













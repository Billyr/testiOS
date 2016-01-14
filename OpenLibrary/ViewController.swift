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
    @IBOutlet weak var resultadoJSON: UITextView!
    
    
    override func viewDidLoad() {
        self.textoBusqueda.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == textoBusqueda {
            textField.resignFirstResponder()
            return false
        }
        return true
    }


    @IBAction func Buscar(sender: AnyObject) {
        var urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        urls.appendContentsOf(textoBusqueda.text!)
        let url = NSURL(string: urls)
        let sesion = NSURLSession.sharedSession()
        
        let bloque = { (datos:NSData?, resp:NSURLResponse?, error:NSError?) -> Void in
        
            // Validar errores
            let http = resp as! NSHTTPURLResponse
            if http.statusCode < 200 || http.statusCode >= 300 {
                print("ERROR: \(http.description)")
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                self.resultadoJSON.text = texto! as String
            }
        }
        
        let dt = sesion.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()
    }
}


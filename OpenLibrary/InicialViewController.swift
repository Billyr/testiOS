//
//  InicialViewController.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 03/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit
import CoreData

class InicialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var context : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let busqueda = NSFetchRequest(entityName: "Libro")

        
        do {
            let datos = try context.executeFetchRequest(busqueda) as! [Libro]
            
            if datos.count > 0 {
                libros = datos
                tableView.reloadData()
            }
            
        } catch {
            print("\(error)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        self.tableView.reloadData()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libros.count
    }
    
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("librocell") as! libroCell
        cell.titulo.text = libros[indexPath.row].titulo
        cell.isbn.text = "ISBN:  \(libros[indexPath.row].isbn)"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detalles = self.storyboard?.instantiateViewControllerWithIdentifier("detalles") as! DetallesViewController
        detalles.libro = libros[indexPath.row]
        self.navigationController?.pushViewController(detalles, animated: true)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            let libro = libros[indexPath.row]
            
            context.deleteObject(libro)
            
            do {
                
                try context.save()
                libros.removeAtIndex(indexPath.row)
            } catch {
                print("\(error)")
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        
    }

    @IBAction func irBusqueda(sender: AnyObject) {
        
        let busqueda = self.storyboard?.instantiateViewControllerWithIdentifier("busqueda") as! BusquedaViewController
        busqueda.context = context
        self.navigationController?.pushViewController(busqueda, animated: true)
        
    }
}

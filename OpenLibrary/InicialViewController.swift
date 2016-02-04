//
//  InicialViewController.swift
//  OpenLibrary
//
//  Created by Billy Rangel on 03/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit

class InicialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    

    @IBAction func irBusqueda(sender: AnyObject) {
        
        let busqueda = self.storyboard?.instantiateViewControllerWithIdentifier("busqueda") as! BusquedaViewController
        self.navigationController?.pushViewController(busqueda, animated: true)
        
    }
}

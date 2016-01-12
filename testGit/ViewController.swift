//
//  ViewController.swift
//  testGit
//
//  Created by Billy Rangel on 11/01/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Saludo(sender: AnyObject) {
        label.text = "Hola Swift";
    }

}


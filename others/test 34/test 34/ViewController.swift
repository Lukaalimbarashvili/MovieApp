//
//  ViewController.swift
//  test 34
//
//  Created by Lucas on 11/18/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dota: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClick(_ sender: Any) {
        
       
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.dota.frame.origin.y -= 300
           
        }) { (f) in
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: {
             
            }) { (f) in
            }
        }
        
        
    }
    
}


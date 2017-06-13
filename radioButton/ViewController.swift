//
//  ViewController.swift
//  radioButton
//
//  Created by 陳建佑 on 13/06/2017.
//  Copyright © 2017 陳建佑. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btns: [radioButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func test(_ sender: UIButton) {
        
        for btn in self.btns {
            if btn == sender {
                btn.isSelected = true
            }
            else {
                btn.isSelected = false
            }
        }
    }

}


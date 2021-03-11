//
//  SetupDoneViewController.swift
//  MicroAuth
//
//  Created by Damon Falck on 11/03/2021.
//

import Cocoa

class SetupDoneViewController: NSViewController {
    
    @IBAction func pressedFinish(_ sender: Any) {
        self.view.window?.close()
    }
    
}

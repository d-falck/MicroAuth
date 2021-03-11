//
//  WelcomeViewController.swift
//  MicroAuth
//
//  Created by Damon Falck on 11/03/2021.
//

import Cocoa

class WelcomeViewController: NSViewController {
    
    @IBAction func continuePressed(_ sender: Any) {
        self.view.window?.close()
        performSegue(withIdentifier: "showPreferences", sender: self)
        print("Closed window")
    }
    
}

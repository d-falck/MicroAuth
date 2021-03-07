//
//  PreferencesViewController.swift
//  MicroAuth
//
//  Created by Damon Falck on 06/03/2021.
//

import Cocoa

class PreferencesViewController: NSViewController {

    @IBOutlet weak var secretField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secretField.placeholderString = "Secret"
        if let secret = UserDefaults.standard.string(forKey: "secret") {
            secretField.stringValue = secret
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func applySettings(_ sender: Any) {
        if secretField.stringValue == "" {
            UserDefaults.standard.removeObject(forKey: "secret")
        } else {
            UserDefaults.standard.set(secretField.stringValue, forKey: "secret")
        }
        dismissPreferences(self)
    }
    
    @IBAction func dismissPreferences(_ sender: Any) {
        self.view.window?.performClose(self)
    }
}


//
//  PreferencesWindowController.swift
//  MicroAuth
//
//  Created by Damon Falck on 08/03/2021.
//

import Cocoa

class PreferencesWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        if let vc = self.contentViewController as? PreferencesViewController {
            if vc.listening {
                vc.updateShortcut(event)
            }
        }
    }

}

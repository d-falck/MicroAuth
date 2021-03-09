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
        NSApp.activate(ignoringOtherApps: true) // Bring window to front
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

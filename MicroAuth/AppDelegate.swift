//
//  AppDelegate.swift
//  MicroAuth
//
//  Created by Damon Falck on 06/03/2021.
//

import Cocoa
import HotKey

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var authView: AuthView?
    var hotKey: HotKey?
    @IBOutlet weak var menu: NSMenu?
    @IBOutlet weak var firstMenuItem: NSMenuItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create status bar item and menu
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.image = NSImage(named: "Icon")
        
        // Add menu (designed in IB)
        if let menu = menu {
            statusItem?.menu = menu
            menu.delegate = self
        }
        
        // Add instance of custom view to top of menu
        authView = AuthView(frame: NSRect(x: 0.0, y: 0.0, width: 250.0, height: 52.0))
        if let item = firstMenuItem {
            item.view = authView
        }
        
        // Add copy hotkey
        hotKey = HotKey(key: .r, modifiers: [.command, .option])
        hotKey?.keyDownHandler = {
            self.authView?.copyCode()
            self.performPaste()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func performPaste() {
        let src = CGEventSource(stateID: .privateState)
        
        let cmdDown = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: true)
        let cmdUp = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: false)
        let vDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
        let vUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
        
        vDown?.flags = CGEventFlags.maskCommand
        
        let loc = CGEventTapLocation.cghidEventTap
        
        cmdDown?.post(tap: loc)
        vDown?.post(tap: loc)
        cmdUp?.post(tap: loc)
        vUp?.post(tap: loc)
    }
}

extension AppDelegate: NSMenuDelegate {
    // Start updating the codes whenever menu opens
    func menuWillOpen(_ menu: NSMenu) {
        authView?.startUpdating()
    }
    
    // Stop updating the codes whenever menu closes
    func menuDidClose(_ menu: NSMenu) {
        authView?.stopUpdating()
    }
}

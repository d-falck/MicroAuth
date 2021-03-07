//
//  AppDelegate.swift
//  MicroAuth
//
//  Created by Damon Falck on 06/03/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var authView: AuthView?
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
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
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

//
//  AppDelegate.swift
//  MicroAuth
//
//  Created by Damon Falck on 06/03/2021.
//

import Cocoa
import HotKey
import Carbon

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var authView: AuthView?
    private var hotKey: HotKey?
    @IBOutlet weak var menu: NSMenu?
    @IBOutlet weak var firstMenuItem: NSMenuItem?
    private var welcomeScreen: NSWindowController?

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
        authView = AuthView(frame: NSRect(x: 0.0, y: 0.0, width: 250.0, height: 50.0))
        if let item = firstMenuItem {
            item.view = authView
        }
        
        // Add copy hotkey
        updateHotkey()
        
        // Potentially show welcome screen
        showWelcomeScreen()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // Pastes the current code into active application using Cmd-V
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
    
    // Updates the hotkey from settings file
    func updateHotkey() {
        // Get chosen shortcut from settings
        if let data = UserDefaults.standard.data(forKey: "shortcut"), let shortcut = try? JSONDecoder().decode(KeyboardShortcut.self, from: data) {
            hotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: shortcut.keyCode, carbonModifiers: shortcut.carbonFlags))
            hotKey!.keyDownHandler = { [weak self] in
                self?.authView?.copyCode()
                self?.performPaste()
            }
        } else {
            hotKey = nil
        }
    }
    
    // Show welcome screen on first launch
    func showWelcomeScreen() {
        if (!UserDefaults.standard.bool(forKey: "launchedBefore")) {
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            welcomeScreen = storyboard.instantiateController(withIdentifier: "welcomeWC") as? NSWindowController
            welcomeScreen?.showWindow(self)
            NSApp.activate(ignoringOtherApps: true) // Bring window to front
        }
    }
}

extension AppDelegate: NSMenuDelegate {
    // Start updating the codes whenever menu opens
    func menuWillOpen(_ menu: NSMenu) {
        updateHotkey()
        authView?.startUpdating()
    }
    
    // Stop updating the codes whenever menu closes
    func menuDidClose(_ menu: NSMenu) {
        updateHotkey()
        authView?.stopUpdating()
    }
}

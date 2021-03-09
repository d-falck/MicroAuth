//
//  AuthView.swift
//  MicroAuth
//
//  Created by Damon Falck on 06/03/2021.
//

import Cocoa
import SwiftOTP

class AuthView: NSView {
    
    @IBOutlet weak var contentView: NSView! // Custom view created in Interface Builder
    @IBOutlet weak var codeLabel: NSTextField!
    @IBOutlet weak var progressBar: NSProgressIndicator!
    
    private var totp: TOTP?
    private var timer: Timer!
    private var timeToRenew: Double! {
        didSet {
            progressBar.doubleValue = timeToRenew
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    // Initialisation code to be run for any constructor
    private func commonInit() {
        // Load custom view from nib
        Bundle.main.loadNibNamed("AuthView", owner: self, topLevelObjects: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        // Set up progress bar bounds
        progressBar.minValue = 0.0
        progressBar.maxValue = 30.0
        
        // Set up authentication provider and get initial update
        calculateTimeToRenew()
        updateProvider()
        updateCode()
    }
    
    // Starts updating the code every 0.1s
    func startUpdating() {
        updateProvider()
        // Start updating the code every 0.1s
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // Stops continuously updating the code
    func stopUpdating() {
        timer?.invalidate()
    }
    
    // Updates the current authentication code
    func updateCode() {
        let now = Date()
        if let code = totp?.generate(time: now) {
            self.codeLabel.stringValue = code
        } else {
            self.codeLabel.stringValue = "------"
        }
    }
    
    // Update progress bar and potentially the code
    @objc func update() {
        calculateTimeToRenew()
        if timeToRenew <= 5.0 {
            updateCode()
        }
    }
    
    // Calculates seconds to next code
    private func calculateTimeToRenew() {
        let unixTime: Double = Date().timeIntervalSince1970
        timeToRenew = ceil(unixTime/30.0)*30.0 - unixTime
    }
    
    // Updates the authentication provider from saved secret in settings
    private func updateProvider() {
        if let secretString = UserDefaults.standard.string(forKey: "secret"), let secret = base32DecodeToData(secretString) {
            totp = TOTP(secret: secret, digits: 6, timeInterval: 30, algorithm: .sha1)
        } else {
            totp = nil
        }
    }
    
    // Updates and returns the authentication code
    func getCode() -> String {
        self.updateCode()
        return self.codeLabel.stringValue
    }
    
    // Copy code to clipboard
    func copyCode() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(getCode(), forType: .string)
    }
    
    // Run when copy button pressed
    @IBAction func copyButtonClicked(_ sender: Any) {
        copyCode()
    }
    
}

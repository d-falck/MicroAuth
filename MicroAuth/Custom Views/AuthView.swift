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
    
    var totp: TOTP!
    var timer: Timer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    // Initialisation code to be run for any constructor
    func commonInit() {
        Bundle.main.loadNibNamed("AuthView", owner: self, topLevelObjects: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        // Set up authentication provider and get initial update
        let secret = base32DecodeToData("ryqdmbsppkhryjdp")!
        totp = TOTP(secret: secret, digits: 6, timeInterval: 30, algorithm: .sha1)
        updateCode()
    }
    
    // Starts updating the code every 0.1s
    func startUpdating() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCode), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // Stops continuously updating the code
    func stopUpdating() {
        timer?.invalidate()
    }
    
    // Updates the current authentication code
    @objc func updateCode() {
        let now = Date()
        if let code = totp.generate(time: now) {
            self.codeLabel.stringValue = code
        }
    }
    
    // Updates and returns the authentication code
    func getCode() -> String {
        self.updateCode()
        return self.codeLabel.stringValue
    }

}

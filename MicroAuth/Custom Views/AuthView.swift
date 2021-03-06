//
//  AuthView.swift
//  MicroAuth
//
//  Created by Damon Falck on 06/03/2021.
//

import Cocoa
import SwiftOTP
import SwiftUI

class AuthView: NSView {
    
    @IBOutlet weak var contentView: NSView! // Custom view created in Interface Builder
    @IBOutlet weak var codeLabel: NSTextField!
    
    @IBOutlet weak var progressCircleView: NSView!
    private var progressCircle: ProgressCircle!
    private var circleOptions = CircleOptions(progress: CGFloat(1.0), monochrome: false)
    
    private var totp: TOTP?
    private var timer: Timer!
    private var timeToRenew: Double! {
        didSet {
            circleOptions.progress = CGFloat(timeToRenew/30.0)
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
        
        // Set up progress circle
        progressCircle = ProgressCircle(options: circleOptions)
        let hostingView = NSHostingView(rootView: progressCircle)
        hostingView.setFrameSize(NSSize(width: 35.0, height: 35.0))
        progressCircleView.addSubview(hostingView)
        
        // Set up authentication provider and get initial update
        updateProvider()
        updateView()
        
    }
    
    // Run when the view is shown
    func startUpdating() {
        // Alter progress circle appearance based on settings
        progressCircleView.isHidden = UserDefaults.standard.bool(forKey: "hideCountdown")
        circleOptions.monochrome = UserDefaults.standard.bool(forKey: "monochromeCircle")
        
        // Update authentication provider
        updateProvider()
        
        // Start updating the code and progress bar every 0.01s
        timer = Timer(timeInterval: 0.01, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // Stops continuously updating the code
    func stopUpdating() {
        timer?.invalidate()
    }
    
    // Update progress bar and potentially the code
    @objc func updateView() {
        updateTimeToRenew() // TODO: avoid calculating these *both* unless necessary
        updateCode()
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
    
    // Calculates seconds to next code
    private func updateTimeToRenew() {
        let unixTime: Double = Date().timeIntervalSince1970
        self.timeToRenew = ceil(unixTime/30.0)*30.0 - unixTime
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

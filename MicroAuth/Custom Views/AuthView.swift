//
//  AuthView.swift
//  MicroAuth
//
//  Created by Damon Falck on 06/03/2021.
//

import Cocoa

class AuthView: NSView {
    
    @IBOutlet weak var contentView: NSView! // Custom view created in Interface Builder
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    // Load custom view from IB and add as subview
    func commonInit() {
        let nib = NSNib(nibNamed: "AuthView", bundle: nil)
        nib!.instantiate(withOwner: self, topLevelObjects: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}

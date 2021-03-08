//
//  KeyboardShortcut.swift
//  MicroAuth
//
//  Created by Damon Falck on 08/03/2021.
//

import Foundation

struct KeyboardShortcut: Codable {
    let function: Bool
    let control: Bool
    let command: Bool
    let shift: Bool
    let option: Bool
    let capsLock: Bool
    let carbonFlags: UInt32
    let characters: String?
    let keyCode: UInt32
    
    var description: String {
        var str = ""
        if function{
            str += "fn"
        }
        if control {
            str += "^"
        }
        if option {
            str += "⌥"
        }
        if command {
            str += "⌘"
        }
        if shift {
            str += "⇧"
        }
        if capsLock {
            str += "⇪"
        }
        if let characters = self.characters {
            str += characters.uppercased()
        }
        return str
    }
}

//
//  MainWindowController.swift
//  MidiTest
//
//  Created by Nigel Rios on 6/18/16.
//  Copyright © 2016 Nigel Rios. All rights reserved.
//

import Cocoa


class MainWindowController: NSWindowController {
    
    var midiClient: MIDIClient?
    var lastPosition: Int = 0
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    override func awakeFromNib() {
        midiClient = MIDIClient(name: "Surf Port 1")
        
    }
    
    @IBAction func sendMIDINote(sender: NSButton) {
        midiClient?.createMIDINote()
    }
    
    
    @IBAction func sendFaderMove(sender: NSSlider) {
        let number = UInt16(sender.integerValue)
        midiClient?.pitchWheel(number)
    }
    
    @IBAction func sendPanning(sender: NSSlider) {
        let number = sender.integerValue
//        print(number)
        var clockwise: Bool
        if number > lastPosition {
            clockwise = true
            lastPosition = number
        } else {
            clockwise = false
            lastPosition = number
        }
        
//        print(lastPosition)
               print(lastPosition)
        midiClient?.panning(UInt(abs(lastPosition)), clockwise: clockwise)
    }
}

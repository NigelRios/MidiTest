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
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    override func awakeFromNib() {
        midiClient = MIDIClient(name: "Surf Port 1")
        
    }
   
//    func createMIDIClients() {
//        send = MIKMIDIClientSourceEndpoint(name: "Surf Port 1")
//        receive = MIKMIDIClientDestinationEndpoint(name: "Surf Port 1", receivedMessagesHandler: nil)
//        
//    }
    
    
    @IBAction func sendMIDINote(sender: NSButton) {
        midiClient?.createMIDINote()
    }
    
}

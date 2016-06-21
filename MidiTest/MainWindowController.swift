//
//  MainWindowController.swift
//  MidiTest
//
//  Created by Nigel Rios on 6/18/16.
//  Copyright © 2016 Nigel Rios. All rights reserved.
//

import Cocoa
import MIKMIDI

class MainWindowController: NSWindowController {
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    var mainWindowController: MainWindowController?
    
    var midiManager = MIKMIDIDeviceManager.sharedDeviceManager()
    
    var send = MIKMIDIClientSourceEndpoint(name: "Surf Port 1")
    var receive = MIKMIDIClientDestinationEndpoint(name: "Surf Port 1", receivedMessagesHandler: nil)
    var myDevice: MIKMIDIDevice?
    
    
    func available() {
            for i in midiManager.virtualSources {
                print(i)
            }
            for i in midiManager.virtualDestinations {
                print(i)
            }
    }

    func createMIDINote() {
        let midiTimeStamp = NSDate()
        let noteOn = MIKMIDINoteOnCommand(note: 60, velocity: 127, channel: 0, timestamp: midiTimeStamp)
        let noteOff = MIKMIDINoteOffCommand(note: 60, velocity: 127, channel: 0, timestamp: midiTimeStamp)
        
        let myArray: [MIKMIDICommand] = [noteOn, noteOff]
        
            for i in midiManager.virtualSources {
                if i.name == "Surf Port 1" {
                    do {
                        try midiManager.sendCommands(myArray, toVirtualEndpoint: send!)
                        print("Note sent")
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
    }

    func createMIDIClients() {
        send = MIKMIDIClientSourceEndpoint(name: "Surf Port 1")
        receive = MIKMIDIClientDestinationEndpoint(name: "Surf Port 1", receivedMessagesHandler: nil)
        
        midiManager = MIKMIDIDeviceManager.sharedDeviceManager()
    }
    
    
    @IBAction func sendMIDINote(sender: NSButton) {
        createMIDINote()
    }
    
}

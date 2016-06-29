//
//  MIDIClient.swift
//  MidiTest
//
//  Created by Nigel Rios on 6/19/16.
//  Copyright © 2016 Nigel Rios. All rights reserved.
//

import Cocoa
import MIKMIDI

class MIDIClient {

    
    var midiManager = MIKMIDIDeviceManager.sharedDeviceManager()
    
    var send: MIKMIDIClientSourceEndpoint?
    var receive: MIKMIDIClientDestinationEndpoint?
    
    //    var myDevice: MIKMIDIDevice?
    
    init(name: String) {
        if let send = MIKMIDIClientSourceEndpoint(name: name) {
            self.send = send
        }
        if let receive = MIKMIDIClientDestinationEndpoint(name: name, receivedMessagesHandler: nil) {
            self.receive = receive
        }
    }
    
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
                if let send = send {
                    do {
                        try midiManager.sendCommands(myArray, toVirtualEndpoint: send)
                        print("Note sent")
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
        }
    }

    
}


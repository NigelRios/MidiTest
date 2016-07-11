//
//  MIDIClient.swift
//  MidiTest
//
//  Created by Nigel Rios on 6/19/16.
//  Copyright © 2016 Nigel Rios. All rights reserved.
//

import Cocoa
import MIKMIDI

class MIDIClient: NSObject {

    
    var midiManager = MIKMIDIDeviceManager.sharedDeviceManager()
    
    var sendPoint: MIKMIDIClientSourceEndpoint?
    var receivePoint: MIKMIDIClientDestinationEndpoint?
    
    //    var myDevice: MIKMIDIDevice?
    
    init(name: String) {
        if let sendPoint = MIKMIDIClientSourceEndpoint(name: name) {
            self.sendPoint = sendPoint
        }
        if let receivePoint = MIKMIDIClientDestinationEndpoint(name: name, receivedMessagesHandler: nil) {
            self.receivePoint = receivePoint
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
    
    func sendMIDI(midiArray: [MIKMIDICommand]) {
        for i in midiManager.virtualSources {
            if i.name == "Surf Port 1" {
                if let sendPoint = sendPoint {
                    do {
                        try midiManager.sendCommands(midiArray, toVirtualEndpoint: sendPoint)
//                        print("Midi sent")
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
        }

    }
    
    func createMIDINote() {
        let midiTimeStamp = NSDate()
        let noteOn = MIKMIDINoteOnCommand(note: 104, velocity: 127, channel: 0, timestamp: midiTimeStamp)
        let noteOnTwo = MIKMIDINoteOnCommand(note: 104, velocity: 0, channel: 0, timestamp: midiTimeStamp)
        let noteOff = MIKMIDINoteOffCommand(note: 60, velocity: 127, channel: 0, timestamp: midiTimeStamp)
        
        let myArray: [MIKMIDICommand] = [noteOn]
        
        for i in midiManager.virtualSources {
            if i.name == "Surf Port 1" {
                if let sendPoint = sendPoint {
                    do {
                        try midiManager.sendCommands(myArray, toVirtualEndpoint: sendPoint)
//                        print("Note sent")
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
        }
    }
    
    
    func panning(lastPosition: UInt, clockwise: Bool) {
        let midiTimeStamp = NSDate()
        
        let panning = MIKMutableMIDIControlChangeCommand()
        panning.channel = 0
        panning.controllerNumber = 16
        if !clockwise {
            panning.dataByte2 = 64 + 1
        } else {
            panning.dataByte2 = 1
        }


//        panning.controllerValue = lastPosition

//        print(panning.dataByte2)
        
        let myArray: [MIKMIDICommand] = [panning]
        
        sendMIDI(myArray)

    }
    
    func pitchWheel(number: UInt16) {
        let midiTimeStamp = NSDate()
        let pitchWheel = MIKMutableMIDIPitchBendChangeCommand()
        pitchWheel.pitchChange = number
        pitchWheel.channel = 0
        
        pitchWheel.timestamp = midiTimeStamp
        
        let myArray: [MIKMIDICommand] = [pitchWheel]
        
        sendMIDI(myArray)
    }

    
}


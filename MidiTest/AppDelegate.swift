//
//  AppDelegate.swift
//  MidiTest
//
//  Created by Nigel Rios on 6/18/16.
//  Copyright © 2016 Nigel Rios. All rights reserved.
//

import Cocoa
import MIKMIDI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

   var mainWindowController: MainWindowController?
    
    var midiManager: MIKMIDIDeviceManager?
    
    var send: MIKMIDIClientSourceEndpoint?
    var receive: MIKMIDIClientDestinationEndpoint?
    var myDevice: MIKMIDIDevice?

    
    
    
    
    
    
    func available() {
        for i in midiManager!.virtualSources {
            print(i)
        }
        for i in midiManager!.virtualDestinations {
            print(i)
        }
    }
   
    
    func sendMIDINote() {
        let midiTimeStamp = NSDate()
        let noteOn = MIKMIDINoteOnCommand(note: 67, velocity: 127, channel: 0, timestamp: midiTimeStamp)
        let noteOff = MIKMIDINoteOffCommand(note: 67, velocity: 127, channel: 0, timestamp: midiTimeStamp.dateByAddingTimeInterval(0.5))
        
        let myArray: [MIKMIDICommand] = [noteOn, noteOff]
        
//        for i in midiManager!.virtualDestinations {
//            if i.name == "Surf Port 1" {
//                midiManager?.sendCommands(myArray, toEndpoint: i) {
//                    do {
//                        try
//                    }
//                }
//            }
//        }
    }
    
    
    
    
    
    
    
    
// MARK: - AppDelegate functions

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Create a window controller with a XIB file of the same name
        let mainWindowController = MainWindowController()
        
        // Put the window of the window controller on screen
        mainWindowController.showWindow(self)
        
        // Set the property to point to the window controller
        self.mainWindowController = mainWindowController
        
        send = MIKMIDIClientSourceEndpoint(name: "Surf Port 1")
        receive = MIKMIDIClientDestinationEndpoint(name: "Surf Port 1", receivedMessagesHandler: nil)
        
        midiManager = MIKMIDIDeviceManager.sharedDeviceManager()
        
        
        
        available()
    }


}

